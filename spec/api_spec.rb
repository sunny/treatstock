# frozen_string_literal: true

require "spec_helper"

RSpec.describe Treatstock::API do
  subject(:api) { described_class.new(private_key: "testkey") }

  describe "#create_printable_pack" do
    let(:fake_post_url) {
      "https://sandbox.treatstock.com/api/v2/printable-packs/" \
      "?private-key=testkey"
    }
    let(:fake_post_body) {
      {
        affiliate_price: "1",
        affiliate_currency: "EUR",

        # TODO: Shouldn't this be "files[]" ?
        files: "http://example.com/file.stl",
      }
    }
    let(:fake_return_body) {
      %({
        "success": true,
        "id": 1,
        "redir": "https://example-redirection-url"
      })
    }

    before do
      stub_request(:post, fake_post_url)
        .with(body: fake_post_body)
        .to_return(
          status: 200,
          body: fake_return_body,
          headers: { "Content-Type" => "application/json" },
        )
    end

    it do
      response = api.create_printable_pack(
        affiliate_price: 1,
        affiliate_currency: "EUR",
        files: ["http://example.com/file.stl"],
      )
      expect(response)
        .to eq(
          "success" => true,
          "id" => 1,
          "redir" => "https://example-redirection-url",
        )
    end
  end
end
