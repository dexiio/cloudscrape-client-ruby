class CloudScrape
  class ExecutionDTO < DTO
    def endpoint
      "executions/#{id}/#{url}"
    end

    private

    def id
      options.fetch(:id)
    end

    def url
      options.fetch(:url)
    end
  end
end
