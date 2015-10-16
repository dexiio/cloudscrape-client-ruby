require "spec_helper"

describe CloudscrapeClient::Executions::Result do
  let(:instance) { described_class.new(response: response) }

  let(:response) do
    {
      headers: %w(name age location avatars errors),
      rows: [rows]
    }
  end

  let(:rows) { ["Chuck", 31, "Manchester", avatars, nil] }
  let(:avatars) { ["https://example.com/avatar1.png"] }

  describe "#as_hash" do
    subject(:as_hash) { instance.as_hash }

    let(:expected_hash) do
      {
        "name" => "Chuck",
        "age" => 31,
        "location" => "Manchester",
        "avatars" => avatars,
        "errors" => nil
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
      expect(age).to eq(31)
    end
  end

  describe "#location" do
    subject(:location) { instance.location }

    it "results location" do
      expect(location).to eq("Manchester")
    end
  end

  describe "#avatars" do
    subject(:avatars_method) { instance.avatars }

    it "results avatars" do
      expect(avatars_method).to eq(avatars)
    end
  end

  describe "#errors" do
    subject(:errors) { instance.errors }

    it "results errors" do
      expect(errors).to be_nil
    end
  end
end
