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

    def verbose?
      CloudScrape.configuration.verbose
    end

    def logger
      CloudScrape.configuration.logger
    end

    def connection(domain)
      Faraday.new(url: domain) do |faraday|
        faraday.request :url_encoded
        faraday.response :logger, logger if verbose?
        faraday.response :multi_json,
                         content_type: /\bjson$/,
                         symbolize_keys: true

        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
