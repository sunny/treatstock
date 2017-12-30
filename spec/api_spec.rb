# frozen_string_literal: true

RSpec.describe Treatstock::API do
  subject(:api) { described_class.new(private_key: "testkey") }

  describe "#create_printable_pack" do
    let(:fake_request_url) {
      "https://sandbox.treatstock.com/api/v2/printable-packs/" \
      "?private-key=testkey"
    }
    let(:fake_request_body) {
      {
        affiliate_price: "12",
        affiliate_currency: "USD",

        # TODO: Shouldn't this be "files[]" ?
        files: "http://example.com/file.stl",
      }
    }
    let(:fake_result_body) {
      %({
        "success": true,
        "id": 1,
        "redir": "https://example-redirection-url"
      })
    }

    before do
      stub_request(:post, fake_request_url)
        .with(body: fake_request_body)
        .to_return(
          status: 200,
          body: fake_result_body,
          headers: { "Content-Type" => "application/json" },
        )
    end

    it do
      response = api.create_printable_pack(
        affiliate_price: 12,
        affiliate_currency: "USD",
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

  describe "#get_printable_pack" do
    let(:fake_request_url) {
      "http://sandbox.treatstock.com/api/v2/printable-packs/42" \
      "?private-key=testkey"
    }
    let(:fake_result_body) {
      %({
        "id": 42,
        "model3d_id": 142,
        "created_at": "2016-11-07 10:54:24",
        "affiliate_price": "12.0000",
        "affiliate_currency": "USD",
        "calculated_min_cost": {
          "materialGroup": "Plastic2",
          "color": "White",
          "cost": 2.53
        }
      })
    }

    before do
      stub_request(:get, fake_request_url)
        .to_return(
          status: 200,
          body: fake_result_body,
          headers: { "Content-Type" => "application/json" },
        )
    end

    it do
      response = api.get_printable_pack(id: 42)
      expect(response)
        .to eq(
          "id" => 42,
          "model3d_id" => 142,
          "created_at" => "2016-11-07 10:54:24",
          "affiliate_price" => "12.0000",
          "affiliate_currency" => "USD",
          "calculated_min_cost" => {
            "materialGroup" => "Plastic2",
            "color" => "White",
            "cost" => 2.53,
          },
        )
    end
  end
end
