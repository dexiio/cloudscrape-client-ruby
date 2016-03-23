class CloudscrapeClient
  class Executions
    class Result
      attr_reader :row

      def initialize(headers:, row:)
        @headers = headers
        @row = row
        build
      end

      def build
        as_hash.each(&define_method_for_header)
      end

      def as_hash
        @as_hash ||= Hash[@headers.zip(row)]
      end

      private

      def define_method_for_header
        ->(key, value) { self.class.send(:define_method, key) { value } }
      end
    end
  end
end
