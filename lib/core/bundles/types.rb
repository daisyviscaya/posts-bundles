module Core
  module Bundles
    class Types

      def self.bundles
        {
          IMG: { 5 => 450, 10 => 800 },
          FLAC: { 3 => 427.5, 6 => 810, 9 => 1147.5 },
          VID: { 3 => 570, 5 => 900, 9 => 1530 }
        }.freeze
      end
    end
  end
end
