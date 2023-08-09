=begin
input = "1 IMG 2 VID 3 FLAC"
Bundles::Validate.call(bundles_input: input)

input.split = ["1", "IMG", "2", "VID", "3", "FLAC"]
=end

module Bundles
  class Validate < BaseInteractor
    BUNDLE_TYPES = Core::Bundles::Types.bundles
    expects do
      required(:bundles_input).filled
    end

    before do
      @valid_format_types = BUNDLE_TYPES.keys.map(&:to_s)
      context.bundles_params = []
    end

    assures do
      required(:bundles_params).filled
    end

    def call
      context.bundles_input.split.each_slice(2).each do |qty, file_type|
        if integer?(qty) && valid_format_type?(file_type)
          context.bundles_params << {
            quantity: qty.to_i,
            format: file_type.upcase
          }
        else
          context.fail!(error: "Invalid input format. Please try again.")
        end
      end
    end

    def integer?(str_input)
      input_to_int = str_input.to_i
      (input_to_int.is_a? Integer) && input_to_int.to_s == str_input
    end

    def valid_format_type?(str_input)
      @valid_format_types.include?(str_input.upcase)
    end
  end
end
