module Core
  module Bundles
    class Calculator
      BUNDLE_TYPES = Core::Bundles::Types.bundles

      def initialize(desired_quantity, format_type)
        @desired_quantity = desired_quantity
        @format_type = format_type
        @bundle_prices = BUNDLE_TYPES[@format_type.to_sym]
        @bundle_kinds = BUNDLE_TYPES[@format_type.to_sym].keys
      end

      def calculate
        bundle_combinations = get_bundle_combinations(@bundle_kinds, @desired_quantity)
        return [] if bundle_combinations.empty?

        cheapest_bundle(bundle_combinations)
      end

      private

      # rubocop: disable Metrics/AbcSize, Metrics/MethodLength
      def get_bundle_combinations(available_bundles, target_price)
        return [] if target_price.zero? || available_bundles.empty?

        this_price = available_bundles[0]
        remaining_bundles = available_bundles[1..]
        results = []

        (1 + (target_price / this_price)).times do |qty|
          remaining_price = target_price - (qty * this_price)
          if remaining_price.zero?
            results << ([qty] + ([0] * remaining_bundles.length))
          else
            get_bundle_combinations(remaining_bundles, remaining_price).each do |option|
              results << ([qty] + option)
            end
          end
        end
        results
      end
      # rubocop: enable Metrics/AbcSize

      def cheapest_bundle(bundle_combinations)
        min_count = nil
        min_price = nil
        min_combination = nil
        bundle_combinations.each do |bundle|
          curr_count = bundle.sum
          curr_price = get_price(bundle)
          next unless min_price.nil? || (curr_count <= min_count && curr_price < min_price)

          min_count = curr_count
          min_price = curr_price
          min_combination = bundle
        end

        min_combination
      end
      # rubocop: enable Metrics/MethodLength

      def get_price(bundle)
        price_total = 0
        bundle.each_with_index do |item_count, index|
          price_per_bundle = @bundle_prices[@bundle_kinds[index]]
          price_total += item_count * price_per_bundle
        end

        price_total
      end
    end
  end
end
