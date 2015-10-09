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

      def initialize
        self.base_url = "https://app.cloudscrape.com/api/"
        self.api_key = nil
        self.account_id = nil
        self.user_agent = "CS-RUBY-CLIENT/1.0"
        self.timeout = 3600
        self.verbose = false
        self.log = false
        self.logger = Logger.new(STDOUT)
      end
    end
  end
end
