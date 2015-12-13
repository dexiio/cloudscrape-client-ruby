class CloudscrapeClient
  class Executions
    class Get
      attr_reader :response

      def initialize(response:)
        @response = response
      end

      def queued?
        %w(QUEUED).include?(state)
      end

      def pending?
        %w(PENDING).include?(state)
      end

      def running?
        %w(RUNNING).include?(state)
      end

      def failed?
        %w(FAILED).include?(state)
      end

      def stopped?
        %w(STOPPED).include?(state)
      end

      def ok?
        %w(OK).include?(state)
      end

      def state
        response.fetch(:state)
      end
    end
  end
end
