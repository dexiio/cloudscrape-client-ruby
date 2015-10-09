require "cloud_scrape/run_dto"

class CloudScrape
  class Runs
    def initialize(id:)
      @id = id
    end

    def execute
      RunDTO.for(id: id, url: "execute", method: :post).fetch(:_id)
    end

    private

    attr_reader :id
  end
end
