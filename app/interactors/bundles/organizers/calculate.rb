=begin
Bundles::Organizers::Calculate.call(
  bundles_input: "10 IMG 15 flac 13 VID"
)
=end

module Bundles
  module Organizers
    class Calculate < BaseInteractor
      include Interactor::Organizer

      expects do
        required(:bundles_input).filled
      end

      organize Bundles::Validate,
               Bundles::Quantify,
               Bundles::Prepare,
               Bundles::Print
    end
  end
end
