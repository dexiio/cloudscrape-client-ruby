class CloudScrape
  class Executions
    class Get
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

      private

      attr_reader :response

      def state
        response.fetch(:state)
      end
    end
  end
end
