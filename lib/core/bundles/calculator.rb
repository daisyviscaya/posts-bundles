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

        # puts "ITO NA"
        cheapest_bundle(bundle_combinations)
      end

      private

      # rubocop: disable Metrics/AbcSize, Metrics/MethodLength
      def get_bundle_combinations(available_bundles, target_price)
        return [] if target_price.zero? || available_bundles.empty?

        this_price = available_bundles[0]
        remaining_products = available_bundles[1..]
        results = []

        (1 + (target_price / this_price)).times do |qty|
          remaining_price = target_price - (qty * this_price)
          if remaining_price.zero?
            results << ([qty] + ([0] * remaining_products.length))
          else
            get_bundle_combinations(remaining_products, remaining_price).each do |option|
              # puts "THISp: #{this_price} qty: #{qty} OPTION: #{option}"
              results << ([qty] + option)
            end
          end
        end
        # print results
        results
      end
      # rubocop: enable Metrics/AbcSize, Metrics/MethodLength

      def cheapest_bundle(bundle_combinations)
        min_sum = @desired_quantity
        min_price = nil
        min_combination = []
        bundle_combinations.each do |bundle|
          next unless min_price.nil? || (bundle.sum <= min_sum && get_price(bundle) < min_price)

          min_sum = bundle.sum
          min_price = get_price(bundle)
          min_combination = bundle
        end

        min_combination
      end

      def get_price(bundle)
        price_total = 0
        bundle.each_with_index do |item_count, index|
          price_total += item_count * @bundle_prices[@bundle_kinds[index]]
        end

        price_total
      end
    end
  end
end
