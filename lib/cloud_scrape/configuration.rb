class CloudScrape
  module Configure
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
      configuration
    end

    private

    class Configuration
      attr_accessor :base_url,
                    :api_key,
                    :account_id,
                    :user_agent,
                    :timeout,
                    :verbose,
                    :log,
                    :logger

      def initialize # rubocop:disable Metrics/AbcSize
        self.base_url = base_url_default
        self.user_agent = user_agent_default
        self.timeout = timeout_default

        self.api_key = ENV["CLOUD_SCRAPE_CLIENT_API_KEY"]
        self.account_id = ENV["CLOUD_SCRAPE_CLIENT_ACCOUNT_ID"]
        self.verbose = ENV["CLOUD_SCRAPE_CLIENT_VERBOSE"] || false
        self.log = ENV["CLOUD_SCRAPE_CLIENT_LOG"] || false

        self.logger = Logger.new(STDOUT)
      end

      private

      def base_url_default
        ENV["CLOUD_SCRAPE_CLIENT_BASE_URL"] ||
          "https://app.cloudscrape.com/api/"
      end

      def user_agent_default
        ENV["CLOUD_SCRAPE_CLIENT_USER_AGENT"] || "CS-RUBY-CLIENT/1.0"
      end

      def timeout_default
        ENV["CLOUD_SCRAPE_CLIENT_TIMEOUT"] || 3600
      end
    end
  end
end
