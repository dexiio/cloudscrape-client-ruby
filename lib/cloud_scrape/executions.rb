require "cloud_scrape/execution_dto"
require "cloud_scrape/executions/get"

class CloudScrape
  class Executions
    def initialize(id:)
      @id = id
    end

    def get
      Get.new(response: dto("", :get))
    end

    def result
      dto("result", :get)
    end

    def remove
      dto("", :delete)
    end

    def stop
      dto("stop", :post)
    end

    def continue
      dto("continue", :post)
    end

    private

    def dto(url, method)
      ExecutionDTO.for(id: @id, url: url, method: method)
    end
  end
end
