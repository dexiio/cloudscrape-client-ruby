require "cloud_scrape/execution_dto"
require "cloud_scrape/executions/get"

class CloudScrape
  class Executions
    def initialize(id:)
      @id = id
    end

    def get
      Get.new(response: ExecutionDTO.for(id: id, url: "", method: :get))
    end

    def result
      ExecutionDTO.for(id: id, url: "result", method: :get)
    end

    def remove
      ExecutionDTO.for(id: id, url: "", method: :delete)
    end

    private

    attr_reader :id
  end
end
