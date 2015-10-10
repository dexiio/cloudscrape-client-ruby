require "spec_helper"

describe CloudScrape::Executions::Result do
  let(:instance) { described_class.new(response: response) }

  let(:response) do
    {
      headers: %w(name age location),
      rows: [
        %w(Chuck 31 Manchester)
      ]
    }
  end

  describe "#as_hash" do
    subject(:as_hash) { instance.as_hash }

    let(:expected_hash) do
      {
        "name" => "Chuck",
        "age" => "31",
        "location" => "Manchester"
      }
    end

    it "results hash with headers as keys and rows as values" do
      expect(as_hash).to eq(expected_hash)
    end
  end

  describe "#name" do
    subject(:name) { instance.name }

    it "results name" do
      expect(name).to eq("Chuck")
    end
  end

  describe "#age" do
    subject(:age) { instance.age }

    it "results age" do
      expect(age).to eq("31")
    end
  end

  describe "#location" do
    subject(:location) { instance.location }

    it "results location" do
      expect(location).to eq("Manchester")
    end
  end
end
