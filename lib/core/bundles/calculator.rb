module Core
  module Bundles
    class Calculator
      BUNDLE_TYPES = {
        IMG: { 5 => 450, 10 => 800 },
        FLAC: { 3 => 427.5, 6 => 810, 9 => 1147.5 },
        VID: { 3 => 570, 5 => 900, 9 => 1530 }
      }.freeze

      def initialize(desired_quantity, format_type)
        @desired_quantity = desired_quantity
        @format_type = format_type
        @available_bundles_price = BUNDLE_TYPES[@format_type.to_sym]
        @available_bundles_count = BUNDLE_TYPES[@format_type.to_sym].keys
      end

      def calculate
        bundle_combinations = get_bundle_combinations(@available_bundles_count, @desired_quantity)
        return nil if bundle_combinations.empty?
        
        puts "ITO NA"
        minimum_bundle(bundle_combinations)
      end

      def get_bundle_combinations(available_bundles, target_price)
        return [] if target_price.zero? || available_bundles.empty?

        this_price = available_bundles[0]
        remaining_products = available_bundles[1..]
        results = []

        (1 + target_price / this_price).times do |qty|
          remaining_price = target_price - qty * this_price
          if remaining_price == 0
            results << ([qty] + [0] * remaining_products.length)
          else
            get_bundle_combinations(remaining_products, remaining_price).each do |option|
              puts "THISp: #{this_price} qty: #{qty} OPTION: #{option}"
              results << ([qty] + option)
            end
          end
        end
        print results
        return results
      end

      def minimum_bundle(bundle_combinations)
        min_sum = @desired_quantity
        min_price = nil
        min_combination = []
        bundle_combinations.each do |bundle|
          if bundle.sum <= min_sum && min_price.present? && get_price(bundle) < min_price || min_price.nil?
            min_sum = bundle.sum
            min_price = get_price(bundle)
            min_combination = bundle
          end
        end

        return min_combination
      end

      def get_price(bundle)
        price_total = 0
        bundle.each_with_index do |item_count, index|
          price_total += item_count * @available_bundles_price[@available_bundles_count[index]]
        end

        price_total
      end

      # def get_minimum_bundle_price(bundle_combinations)
      #   min_price_total = 0
      #   min_price_combination = []
      #   bundle_combinations.each do |bundle|
      #     price_total = 0
      #     bundle.each do |c|
      #       price_total += c * @available_bundles_price[@available_bundles_count[bundle.find_index(c)]]
      #     end

      #     if min_price_total < price_total
      #       min_price_combination = bundle
      #       min_price_total = price_total
      #     end
      #   end

      #   return min_price_combination
      # end
    end
  end
end
