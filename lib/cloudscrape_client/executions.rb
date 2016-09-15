# frozen_string_literal: true

require "cloudscrape_client/execution_dto"
require "cloudscrape_client/executions/get"
require "cloudscrape_client/executions/result"
require "cloudscrape_client/executions/results"

class CloudscrapeClient
  class Executions
    def initialize(id:)
      @id = id
    end

    def get
      Get.new(response: dto("", :get))
    end

    def results
      @results ||= Results.new(response: dto("result", :get))
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
