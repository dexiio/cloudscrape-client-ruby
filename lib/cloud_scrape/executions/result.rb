class CloudScrape
  class Executions
    class Result
      attr_reader :response

      def initialize(response:)
        @response = response
        build
      end

      def build
        as_hash.each(&define_method_for_header)
      end

      def as_hash
        @as_hash ||= Hash[headers.zip(rows)]
      end

      private

      def headers
        response.fetch(:headers, [])
      end

      def rows
        response.fetch(:rows, [])
      end

      def define_method_for_header
        ->(key, value) { self.class.send(:define_method, key) { value } }
      end
    end
  end
end
