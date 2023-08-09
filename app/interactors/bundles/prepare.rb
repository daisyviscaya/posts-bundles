=begin
context = Bundles::Prepare.call(
  resulted_bundles: [{ bundle_combination: [2, 0, 2], quantity: 24, format: "VID" }]
)

context.body = [{ quantity: 24, format: "VID", total: 4200,
  breakdown: [{ type: 3, quantity: 2, price: 1140 }, { type: 5, quantity: 0, price: 0 },
              { type: 9, quantity: 2, price: 3060 }]
  }]
=end

module Bundles
  class Prepare < BaseInteractor
    BUNDLE_TYPES = Core::Bundles::Types.bundles

    expects do
      required(:resulted_bundles).filled
    end

    before do
      context.body = []
    end

    assures do
      required(:body).filled
    end

    def call
      context.resulted_bundles.each do |bundle|
        bundle_prices = BUNDLE_TYPES[bundle[:format].to_sym]
        bundle_kinds = bundle_prices.keys
        append_to_response_body(bundle, bundle_prices, bundle_kinds)
      end
    end

    def append_to_response_body(bundle, bundle_prices, bundle_kinds)
      results = get_total_and_breakdown(bundle, bundle_prices, bundle_kinds)
      context.body << bundle.slice(:quantity, :format).merge(
        { total: results[:total], breakdown: results[:bundle_breakdown] }
      )
    end

    def get_total_and_breakdown(bundle, bundle_prices, bundle_kinds)
      price_total = 0
      breakdown = []
      bundle[:bundle_combination].each_with_index do |item_count, index|
        price_per_bundle = bundle_prices[bundle_kinds[index]]
        price_total += item_count * price_per_bundle
        breakdown << build_breakdown(bundle_kinds[index], item_count, price_per_bundle)
      end

      { total: price_total, bundle_breakdown: breakdown }
    end

    def build_breakdown(bundle_type, bundle_count, bundle_price)
      {
        type: bundle_type,
        quantity: bundle_count,
        price: bundle_price * bundle_count
      }
    end
  end
end
