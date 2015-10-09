require "spec_helper"

RSpec.describe CloudScrape::Configure, type: :config do
  let(:instance) { Class.new { extend CloudScrape::Configure } }

  describe "#base_url" do
    subject { instance.configuration.base_url }

    let(:new_url) { "https://app.cloudscrape.com/api/v2/" }

    it "returns default" do
      expect(subject).to eq("https://app.cloudscrape.com/api/")
    end

    it "returns altered" do
      instance.configure { |config| config.base_url = new_url }
      expect(subject).to eq(new_url)
    end
  end

  describe "#api_key" do
    subject { instance.configuration.api_key }

    let(:new_api_key) { "123" }

    it "returns default" do
      expect(subject).to eq(nil)
    end

    it "returns altered" do
      instance.configure { |config| config.api_key = new_api_key }
      expect(subject).to eq(new_api_key)
    end
  end

  describe "#account_id" do
    subject { instance.configuration.account_id }

    let(:new_account_id) { "123" }

    it "returns default" do
      expect(subject).to eq(nil)
    end

    it "returns altered" do
      instance.configure { |config| config.account_id = new_account_id }
      expect(subject).to eq(new_account_id)
    end
  end

  describe "#user_agent" do
    subject { instance.configuration.user_agent }

    let(:new_user_agent) { "MY-USER-AGENT/2.0" }

    it "returns default" do
      expect(subject).to eq("CS-RUBY-CLIENT/1.0")
    end

    it "returns altered" do
      instance.configure { |config| config.user_agent = new_user_agent }
      expect(subject).to eq(new_user_agent)
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
  end

  describe "#log" do
    subject { instance.configuration.log }

    it "returns default" do
      expect(subject).to eq(false)
    end

    it "returns altered" do
      instance.configure { |config| config.log = true }
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
