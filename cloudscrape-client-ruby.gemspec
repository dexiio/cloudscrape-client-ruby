# frozen_string_literal: true

# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "cloudscrape_client/version"

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name          = "cloudscrape-client"
  spec.version       = CloudscrapeClient::VERSION
  spec.authors       = ["Charles J Hardy"]
  spec.email         = ["support@dexi.io"]

  spec.summary       = "Wrapper for CloudScrape API"
  spec.description   = "Wrapper for CloudScrape API"
  spec.homepage      = "https://github.com/cloudscrape/cloudscrape-client-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "mime-types", "~> 3.1"
  spec.add_runtime_dependency "faraday", "~> 0.9"
  spec.add_runtime_dependency "faraday_middleware", "~> 0.10"
  spec.add_runtime_dependency "faraday-conductivity", "~> 0.3"
  spec.add_runtime_dependency "faraday_middleware-multi_json", "~> 0.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency 'pry-byebug'
end
# rubocop:enable Metrics/BlockLength
