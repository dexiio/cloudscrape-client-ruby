class CloudscrapeClient
  class Executions
    class Result
      class File
        ParseError = Class.new(StandardError)

        # https://regex101.com/r/zS8xF6/1
        REGEX = /\AFILE:(?'contentType'\w+\/\w+);(?'providerId'\d+);(?'id'[a-z0-9-]*)\Z/
        EXPECTED_FORMAT = "FILE:<CONTENT_TYPE>;<PROVIDER_ID>;<FILE_ID>"

        def initialize(value)
          @value = value
        end

        def id
          @id ||= find("id")
        end

        def provider_id
          @provider_id ||= find("providerId")
        end

        def content_type
          @content_type ||= find("contentType")
        end

        private

        attr_reader :value

        def find(key)
          value.match(REGEX)[key]
        rescue NoMethodError
          raise ParseError, "Expected: #{EXPECTED_FORMAT}, Got: #{value}"
        end
      end
    end
  end
end
