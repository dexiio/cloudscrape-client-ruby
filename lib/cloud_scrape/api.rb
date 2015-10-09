require "digest"
require "faraday"
require "faraday_middleware"
require "faraday_middleware/multi_json"

class CloudScrape
  class API
    def self.get(*args)
      new.get(*args)
    end

    def self.post(*args)
      new.post(*args)
    end

    def self.delete(*args)
      new.delete(*args)
    end

    def get(domain:, url:, options: {})
      connection(domain).get(URI.escape(url), options)
    end

    def post(domain:, url:, options: {})
      connection(domain).post do |req|
        req.url URI.escape(url)
        req.body = URI.encode_www_form(options)
      end
    end

    def delete(domain:, url:, options: {})
      connection(domain).delete(URI.escape(url), options)
    end

    private

    def access_key
      Digest::MD5.hexdigest(account_id + CloudScrape.configuration.api_key)
    end

    def account_id
      CloudScrape.configuration.account_id
    end

    def connection(domain)
      Faraday.new(url: domain) do |faraday|
        faraday.request :url_encoded

        faraday.request :user_agent,
          app: CloudScrape.configuration.user_agent_app,
          version: CloudScrape.configuration.user_agent_version

        faraday.request :request_headers,
          accept: "application/json",
          x_cloud_scrape_access: access_key,
          x_cloud_scrape_account: account_id,
          content_type: "application/json"

        if CloudScrape.configuration.verbose
          faraday.response :logger, CloudScrape.configuration.logger
        end

        faraday.response :multi_json,
                         content_type: /\bjson$/,
                         symbolize_keys: true

        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
