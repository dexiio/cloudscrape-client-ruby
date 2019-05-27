# frozen_string_literal: true

require "cloudscrape_client/executions/result/file"

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
        lambda do |key, value|
          define_singleton_method(key) do
            value.to_s.include?(File::FILE_KEYWORD) ? File.new(value) : value
          end
        end
      end
    end
  end
end
