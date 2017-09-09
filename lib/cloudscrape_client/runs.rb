# frozen_string_literal: true

require "cloudscrape_client/run_dto"

class CloudscrapeClient
  class Runs
    def initialize(id:)
      @id = id
    end

    def execute(input: {}, connect: false)
      RunDTO.for(
        id: @id,
        url: url(input),
        input: input,
        connect: connect,
        method: :post
      ).fetch(:_id)
    end

    private

    def url(input)
      if input.empty?
        "execute"
      elsif input.is_a?(Array)
        "execute/bulk"
      else
        "execute/inputs"
      end
    end
  end
end
