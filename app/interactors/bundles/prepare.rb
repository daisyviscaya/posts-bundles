"""
Bundles::Prepare.call(
  resulted_bundles: [
    { bundle_combination: [2, 0, 2], quantity: 24, format: 'VID'}
  ]
)

context.body = [{
  quantity: , format: , total: , breakdown: [{ type: , quantity: , price: }]
}]
"""

module Bundles
  class Prepare < BaseInteractor
    BUNDLE_TYPES = Core::Bundles::Types.bundles

    expects do
      required(:resulted_bundles).filled
    end

    before do
      context.body = []
    end

    def call
      context.resulted_bundles.each do |bundle|
        bundle_prices = BUNDLE_TYPES[bundle[:format].to_sym]
        bundle_kinds = bundle_prices.keys
        breakdown = []
        price_total = 0

        bundle[:bundle_combination].each_with_index do |item_count, index|
          item_price = 0
          price_total += item_count * bundle_prices[bundle_kinds[index]]
          breakdown << {
            type: bundle_kinds[index],
            quantity: item_count,
            price: bundle_prices[bundle_kinds[index]] * item_count
          }
        end

        context.body << bundle.slice(:quantity, :format).merge(
          {
            total: price_total,
            breakdown: breakdown
          }
        )
      end
    end
  end
end