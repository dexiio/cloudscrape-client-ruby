require "cloud_scrape/execution_dto"

class CloudScrape
  class Executions
    def initialize(id:)
      @id = id
    end

    def result
      ExecutionDTO.for(id: id, url: "result", method: :get)
    end

    private

    attr_reader :id
  end
end
