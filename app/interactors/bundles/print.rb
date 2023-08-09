=begin
body = [{ quantity: 10, format: "IMG", total: 800,
          breakdown: [{ type: 5, quantity: 0, price: 0 }, { type: 10, quantity: 1, price: 800 }] }]
Bundles::Print.call(body: body)
=end

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
