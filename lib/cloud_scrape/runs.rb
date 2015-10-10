require "cloud_scrape/run_dto"

class CloudScrape
  class Runs
    def initialize(id:)
      @id = id
    end

    def execute(input={})
      url = input.empty? ? "execute" : "execute/inputs"
      dto(url, :post, input).fetch(:_id)
    end

    private

    def dto(url, method, input)
      RunDTO.for(id: @id, url: url, input: input, method: method)
    end
  end
end
