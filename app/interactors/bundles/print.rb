"""
body = [
  { quantity: , format: , total: , breakdown: [{ type: , quantity: , price: }] }
]
Bundles::Print.call(
  body: body
)
"""

module Bundles
  class Print < BaseInteractor
    expects do
      required(:body).filled
    end

    def call
      context.body.each do |item|
        puts "#{item[:quantity]} #{item[:format]} -> $#{item[:total]}"
        item[:breakdown].each do |bundle_type|
          next if bundle_type[:quantity].zero?
          puts "\t #{bundle_type[:quantity]} x #{bundle_type[:type]} -> $#{bundle_type[:price]}"
        end
        puts "----------"
      end
    end
  end
end
