class CloudScrape
  class RunDTO < DTO
    def endpoint
      "runs/#{id}/#{url}"
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
