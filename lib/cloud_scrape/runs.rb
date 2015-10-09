require "cloud_scrape/run_dto"

class CloudScrape
  class Runs
    def initialize(id:)
      @id = id
    end

    def execute
      RunDTO.for(id: id, url: "executions")
    end

    private

    attr_reader :id
  end
end
