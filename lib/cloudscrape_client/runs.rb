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
      case input
      when Array
        "execute/bulk"
      when Hash
        "execute/inputs"
      else
        "execute"
      end
    end
  end
end
