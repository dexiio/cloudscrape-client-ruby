# frozen_string_literal: true

require "logger"
require "mime/types"

require "cloudscrape_client/version"
require "cloudscrape_client/configuration"
require "cloudscrape_client/dto"
require "cloudscrape_client/runs"
require "cloudscrape_client/executions"

class CloudscrapeClient
  extend Configure

  NotFound = Class.new(StandardError)
  InternalServerError = Class.new(StandardError)

  def initialize(api_key: nil, account_id: nil)
    CloudscrapeClient.configuration.api_key = api_key if api_key
    CloudscrapeClient.configuration.account_id = account_id if account_id
  end

  def runs(id)
    Runs.new(id: id)
  end

  def executions(id)
    Executions.new(id: id)
  end
end
