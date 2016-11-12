# frozen_string_literal: true

class CloudscrapeClient
  class Executions
    class Results
      attr_reader :response

      def initialize(response:)
        @response = response
      end

      def as_hash
        collection.map(&:as_hash)
      end

      def collection
        response.fetch(:rows, [[]]).map(&result)
      end

      private

      def headers
        response.fetch(:headers, [])
      end

      def result
        lambda do |row|
          CloudscrapeClient::Executions::Result.new(headers: headers, row: row)
        end
      end
    end
  end
end
