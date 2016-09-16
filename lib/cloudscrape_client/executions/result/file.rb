# frozen_string_literal: true

class CloudscrapeClient
  class Executions
    class Result
      class File
        ParseError = Class.new(StandardError)

        DEFAULT_EXTENSION = "zip"
        FILE_KEYWORD = "FILE"
        # https://regex101.com/r/zS8xF6/1
        REGEX = %r{
          \A                       # start of line
          #{FILE_KEYWORD}          # detector keywork
          :                        # detector vs content split
          (?'contentType'\w+\/\w+) # content type
          ;                        # first split
          (?'providerId'\d+)       # Dexi provider id
          ;                        # second split
          (?'id'[a-z0-9-]*)        # file id
          \Z                       # end of line
        }x
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

        # ContentType list http://www.freeformatter.com/mime-types-list.html
        def content_type
          @content_type ||= find("contentType")
        end

        def file_name
          "#{id}-#{provider_id}.#{extension}"
        end

        def extension
          content_type.split("/").last || DEFAULT_EXTENSION
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
