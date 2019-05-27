# frozen_string_literal: true

require "spec_helper"

RSpec.describe CloudscrapeClient::Executions::Results do
  let(:instance) { described_class.new(response: response) }

  let(:response) do
    {
      headers: %w(name age location avatars errors),
      rows: [row1, row2]
    }
  end

  let(:row1) { ["Chuck", 31, "Manchester", avatars, nil] }
  let(:row2) { ["James", 26, "London", avatars, nil] }
  let(:avatars) { ["https://example.com/avatar1.png"] }

  describe "#as_hash" do
    subject(:as_hash) { instance.as_hash }

    let(:expected_hash) do
      [
        {
          "name" => "Chuck",
          "age" => 31,
          "location" => "Manchester",
          "avatars" => avatars,
          "errors" => nil
        },
        {
          "name" => "James",
          "age" => 26,
          "location" => "London",
          "avatars" => avatars,
          "errors" => nil
        }
      ]
    end

    it "results hash with headers as keys and rows as values" do
      expect(as_hash).to eq(expected_hash)
    end
  end

  describe "#collection" do
    subject(:collection) { instance.collection }

    it "returns a collection of Result objects" do
      expect(collection.map(&:class)).to eq(
        [
          CloudscrapeClient::Executions::Result,
          CloudscrapeClient::Executions::Result
        ]
      )
    end

    it "returns the right values for each Result object" do
      expect(collection.map(&:name)).to eq ["Chuck", "James"]
      expect(collection.map(&:age)).to eq [31, 26]
      expect(collection.map(&:location)).to eq ["Manchester", "London"]
    end
  end
end
