require 'cloud_scrape/api'

class CloudScrape
  class DTO
    attr_reader :options

    def initialize(options:)
      @options = options
    end

    def self.get(options = {})
      new(options: options).response(:get)
    end

    def self.post(options = {})
      new(options: options).response(:post)
    end

    def self.delete(options = {})
      new(options: options).response(:delete)
    end

    def response(method)
      API.public_send(
        method,
        domain: domain,
        url: endpoint,
        options: {
          api_key: api_key,
          format: 'json'
        }.merge(params)
      ).body
    end

    def params
      {}
    end

    def endpoint
      fail NotImplementedError, 'Inheriting class must implement'
    end

    private

    def domain
      CloudScrape.configuration.base_url
    end

    def api_key
      CloudScrape.configuration.api_key
    end
  end
end
