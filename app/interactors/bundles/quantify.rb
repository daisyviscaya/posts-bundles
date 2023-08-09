"""
Bundles::Quantify.call(
  bundles_params: [
    { quantity: 24, format: 'VID' },
    { quantity: 30, format: 'IMG' }
  ]
)

Bundles::Quantify.call(
  bundles_params: [
    { quantity: 12, format: 'IMG' }
  ]
)
"""

module Bundles
  class Quantify < BaseInteractor
    expects do
      required(:bundles_params).each do
        schema do
          required(:quantity).filled(:int?)
          required(:format).filled(:str?)
        end
      end
    end

    def call
      resulted_bundles = []
      context.bundles_params.each do |bundle|
        result = Core::Bundles::Calculator.new(bundle[:quantity], bundle[:format]).calculate

        resulted_bundles << {
          quantity: bundle[:quantity],
          format: bundle[:format],
          bundle_combination: result
        }
      end

      context.resulted_bundles = resulted_bundles
    end
  end
end
