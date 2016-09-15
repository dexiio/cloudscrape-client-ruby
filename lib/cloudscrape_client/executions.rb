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
      response = dto(
        url: "",
        method: :get
      )

      Get.new(response: response)
    end

    def results
      response = dto(
        url: "result",
        method: :get
      )

      Results.new(response: response)
    end

    def remove
      dto(url: "", method: :delete)
    end

    def stop
      dto(url: "stop", method: :post)
    end

    def continue
      dto(url: "continue", method: :post)
    end

    private

    def dto(url:, method:, record_id: nil, content_type: nil)
      ExecutionDTO.for(
        url: url,
        method: method,
        content_type: content_type,
        execution_id: @id,
        record_id: record_id
      )
    end
  end
end
