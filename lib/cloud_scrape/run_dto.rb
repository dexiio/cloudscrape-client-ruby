class CloudScrape
  class RunDTO < DTO
    def endpoint
      "runs/#{id}/#{url}?connect=#{connect}"
    end

    private

    def id
      options.fetch(:id)
    end

    def url
      options.fetch(:url)
    end

    def connect
      options.fetch(:connect)
    end

    def params
      options.fetch(:input)
    end
  end
end
