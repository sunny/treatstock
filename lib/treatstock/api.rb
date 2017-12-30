# frozen_string_literal: true

module Treatstock
  # Handle all calls to the API.
  #
  # Documentation:
  # - https://www.treatstock.fr/help/article/83-api-documentation
  class API
    def initialize(private_key:)
      @private_key = private_key
    end

    def create_printable_pack(affiliate_price:, affiliate_currency:, files:)
      url = "https://sandbox.treatstock.com/api/v2/printable-packs/"
      HTTP.post(
        url,
        params: { "private-key": private_key },
        form: {
          affiliate_price: affiliate_price,
          affiliate_currency: affiliate_currency,
          "files[]": files,
        },
      ).parse
    end

    def get_printable_pack(id:)
      url = "http://sandbox.treatstock.com/api/v2/printable-packs/#{id}"
      HTTP.get(url, params: { "private-key": private_key }).parse
    end

    private

    attr_reader :private_key
  end
end
