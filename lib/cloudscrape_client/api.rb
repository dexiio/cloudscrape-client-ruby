# frozen_string_literal: true

require "digest"
require "faraday"
require "faraday_middleware"
require "faraday/conductivity"
require "faraday_middleware/multi_json"

class CloudscrapeClient
  class API
    InvalidApiKey = Class.new(StandardError)
    InvalidAccountId = Class.new(StandardError)

    DEFAULT_CONTENT_TYPE = "application/json"

    def self.get(*args)
      new.get(*args)
    end

    def self.post(*args)
      new.post(*args)
    end

    def self.delete(*args)
      new.delete(*args)
    end

    def get(domain:, url:, content_type:, options: {})
      connection(domain: domain, content_type: content_type)
        .get(URI.escape(url), options)
    end

    def post(domain:, url:, content_type:, options: {})
      connection(domain: domain, content_type: content_type).post do |req|
        req.url URI.escape(url)
        req.body = options.to_json
      end
    end

    def delete(domain:, url:, content_type:, options: {})
      connection(domain: domain, content_type: content_type)
        .delete(URI.escape(url), options)
    end

    private

    def access_key
      raise InvalidAccountId, account_id unless account_id
      raise InvalidApiKey, api_key unless api_key

      Digest::MD5.hexdigest(account_id + api_key)
    end

    def account_id
      CloudscrapeClient.configuration.account_id
    end

    def api_key
      CloudscrapeClient.configuration.api_key
    end

    def user_agent_version
      CloudscrapeClient.configuration.user_agent_version
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def connection(domain:, content_type:)
      Faraday.new(url: domain) do |faraday|
        faraday.request :url_encoded

        faraday.request :user_agent,
                        app: CloudscrapeClient.configuration.user_agent_app,
                        version: user_agent_version

        faraday.request :request_headers,
                        accept: "application/json",
                        "X-CloudScrape-Access" => access_key,
                        "X-CloudScrape-Account" => account_id,
                        content_type: content_type.to_s || DEFAULT_CONTENT_TYPE

        if CloudscrapeClient.configuration.verbose
          faraday.response :logger, CloudscrapeClient.configuration.logger
        end

        faraday.response :multi_json,
                         content_type: /\bjson$/,
                         symbolize_keys: true

        faraday.adapter Faraday.default_adapter
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength
  end
end
