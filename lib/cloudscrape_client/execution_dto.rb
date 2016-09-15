# frozen_string_literal: true

class CloudscrapeClient
  class ExecutionDTO < DTO
    def endpoint
      ["executions", execution_id, url, record_id].compact.join("/")
    end

    private

    def record_id
      options[:record_id]
    end

    def execution_id
      options.fetch(:execution_id)
    end

    def url
      options.fetch(:url)
    end

    def content_type
      options[:content_type]
    end
  end
end
