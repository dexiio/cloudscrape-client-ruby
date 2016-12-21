# frozen_string_literal: true

require "spec_helper"

RSpec.describe CloudscrapeClient::Configure do
  let(:instance) { Class.new { extend CloudscrapeClient::Configure } }

  describe "#base_url" do
    subject { instance.configuration.base_url }

    let(:new_url) { "https://api.dexi.io/v2/" }
    let(:env_var_url) { "https://api.dexi.io/v3/" }

    it "returns default" do
      expect(subject).to eq("https://api.dexi.io/")
    end

    it "returns altered" do
      instance.configure { |config| config.base_url = new_url }
      expect(subject).to eq(new_url)
    end

    it "returns from ENV Var" do
      stub_const("ENV", "CLOUD_SCRAPE_CLIENT_BASE_URL" => env_var_url)
      expect(subject).to eq(env_var_url)
    end
  end

  describe "#api_key" do
    subject { instance.configuration.api_key }

    let(:new_api_key) { "123" }
    let(:env_var_api_key) { "987" }

    it "returns default" do
      expect(subject).to eq(nil)
    end

    it "returns altered" do
      instance.configure { |config| config.api_key = new_api_key }
      expect(subject).to eq(new_api_key)
    end

    it "returns from ENV Var" do
      stub_const("ENV", "CLOUD_SCRAPE_CLIENT_API_KEY" => env_var_api_key)
      expect(subject).to eq(env_var_api_key)
    end
  end

  describe "#account_id" do
    subject { instance.configuration.account_id }

    let(:new_account_id) { "123" }
    let(:env_var_account_id) { "987" }

    it "returns default" do
      expect(subject).to eq(nil)
    end

    it "returns altered" do
      instance.configure { |config| config.account_id = new_account_id }
      expect(subject).to eq(new_account_id)
    end

    it "returns from ENV Var" do
      stub_const("ENV", "CLOUD_SCRAPE_CLIENT_ACCOUNT_ID" => env_var_account_id)
      expect(subject).to eq(env_var_account_id)
    end
  end

  describe "#user_agent_app" do
    subject { instance.configuration.user_agent_app }

    let(:new_user_agent_app) { "MY-USER-AGENT" }
    let(:env_var_user_agent_app) { "MY-AGENT" }

    it "returns default" do
      expect(subject).to eq("CS-RUBY-CLIENT")
    end

    it "returns altered" do
      instance.configure do |config|
        config.user_agent_app = new_user_agent_app
      end

      expect(subject).to eq(new_user_agent_app)
    end

    it "returns from ENV Var" do
      stub_const(
        "ENV",
        "CLOUD_SCRAPE_CLIENT_USER_AGENT_APP" => env_var_user_agent_app
      )

      expect(subject).to eq(env_var_user_agent_app)
    end
  end

  describe "#user_agent_version" do
    subject { instance.configuration.user_agent_version }

    let(:new_user_agent_version) { "2.0" }
    let(:env_var_user_agent_version) { "3.0" }

    it "returns default" do
      expect(subject).to eq("1.0")
    end

    it "returns altered" do
      instance.configure do |config|
        config.user_agent_version = new_user_agent_version
      end

      expect(subject).to eq(new_user_agent_version)
    end

    it "returns from ENV Var" do
      stub_const(
        "ENV",
        "CLOUD_SCRAPE_CLIENT_USER_AGENT_VERSION" => env_var_user_agent_version
      )

      expect(subject).to eq(env_var_user_agent_version)
    end
  end

  describe "#timeout" do
    subject { instance.configuration.timeout }

    let(:new_timeout) { 600_00 }
    let(:env_var_timeout) { 100 }

    it "returns default" do
      expect(subject).to eq(3600)
    end

    it "returns altered" do
      instance.configure { |config| config.timeout = new_timeout }
      expect(subject).to eq(new_timeout)
    end

    it "returns from ENV Var" do
      stub_const("ENV", "CLOUD_SCRAPE_CLIENT_TIMEOUT" => env_var_timeout)
      expect(subject).to eq(env_var_timeout)
    end
  end

  describe "#verbose" do
    subject { instance.configuration.verbose }

    it "returns default" do
      expect(subject).to eq(false)
    end

    it "returns altered" do
      instance.configure { |config| config.verbose = true }
      expect(subject).to eq(true)
    end

    it "returns from ENV Var" do
      stub_const("ENV", "CLOUD_SCRAPE_CLIENT_VERBOSE" => true)
      expect(subject).to eq(true)
    end
  end

  describe "#logger" do
    subject { instance.configuration.logger }

    it "returns default" do
      expect(subject).to be_an_instance_of(Logger)
    end

    it "returns altered" do
      instance.configure { |config| config.logger = nil }
      expect(subject).to be_nil
    end
  end
end
