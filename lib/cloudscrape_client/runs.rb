require "cloudscrape_client/run_dto"

class CloudscrapeClient
  class Runs
    def initialize(id:)
      @id = id
    end

    def execute(input: {}, connect: false)
      RunDTO.for(
        id: @id,
        url: (input.empty? ? "execute" : "execute/inputs"),
        input: input,
        connect: connect,
        method: :post
      ).fetch(:_id)
    end
  end
end
