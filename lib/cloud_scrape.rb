require "logger"

require "cloud_scrape/version"
require "cloud_scrape/configuration"
require "cloud_scrape/dto"
require "cloud_scrape/runs"
require "cloud_scrape/executions"

class CloudScrape
  extend Configure

  def runs(id)
    Runs.new(id: id)
  end

  def executions(id)
    Executions.new(id: id)
  end
end
