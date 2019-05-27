# frozen_string_literal: true

require "spec_helper"

RSpec.describe CloudscrapeClient::Executions::Result::File do
  let(:instance) { described_class.new(value) }

  let(:value) { "FILE:image/png;26071;testaccount/11fed7f0-a508-4dc8-956a-481535c6f88a" }

  describe "#id" do
    subject(:id) { instance.id }

    it "returns id parsed from value" do
      expect(id).to eq("testaccount/11fed7f0-a508-4dc8-956a-481535c6f88a")
    end

    context "when id is not found" do
      let(:value) { "FILE:;26071;" }

      let(:msg) do
        "Expected: FILE:<CONTENT_TYPE>;<PROVIDER_ID>;<FILE_ID>, \
Got: FILE:;26071;"
      end

      it "raises an error" do
        expect { id }.to raise_error(
          CloudscrapeClient::Executions::Result::File::ParseError, msg
        )
      end
    end
  end

  describe "#provider_id" do
    subject(:provider_id) { instance.provider_id }

    it "returns provider id parsed from value" do
      expect(provider_id).to eq("26071")
    end
  end

  describe "#content_type" do
    subject(:content_type) { instance.content_type }

    it "returns content type parsed from value" do
      expect(content_type).to eq("image/png")
    end

    context "when id is not found" do
      let(:value) { "FILE:;26071;11fed7f0-a508-4dc8-956a-481535c6f88a" }

      let(:msg) do
        "Expected: FILE:<CONTENT_TYPE>;<PROVIDER_ID>;<FILE_ID>, \
Got: FILE:;26071;11fed7f0-a508-4dc8-956a-481535c6f88a"
      end

      it "raises an error" do
        expect { content_type }.to raise_error(
          CloudscrapeClient::Executions::Result::File::ParseError, msg
        )
      end
    end

    context "when format is unknown" do
      let(:value) { "FILE:not/exist;26071;11fed7f0-a508-4dc8-956a" }

      let(:msg) { "not/exist" }

      it "raises an error" do
        expect { content_type }.to raise_error(
          CloudscrapeClient::Executions::Result::File::UnknownContentType, msg
        )
      end
    end
  end

  describe "#file_name" do
    subject(:file_name) { instance.file_name }

    it "returns expected file name" do
      expect(file_name).to eq("testaccount/11fed7f0-a508-4dc8-956a-481535c6f88a-26071.png")
    end
  end

  describe "#extension" do
    subject(:extension) { instance.extension }

    it "returns expected extension" do
      expect(extension).to eq("png")
    end
  end
end
