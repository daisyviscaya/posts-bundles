require "rails_helper"

describe Bundles::Prepare do
  describe "when input is missing or invalid" do
    let(:context) { described_class.call() }

    it "should fail" do
      expect(context).to be_a_failure
    end

    it "should not add body to context" do
      expect(context.body).to be_nil
    end
  end

  describe "when input is valid" do
    let(:params) do
      { resulted_bundles: [{ bundle_combination: [2, 0, 2], quantity: 24, format: "VID" }] }
    end
    let(:context) { described_class.call(params) }

    it "should succeed" do
      expect(context).to be_a_success
    end

    it "should add body to context" do
      expect(context.body).to be_present
    end

    it "should have correct values for context.body" do
      expect(context.body).to eq(
        [{
          quantity: 24, format: "VID", total: 4200,
          breakdown: [
            { type: 3, quantity: 2, price: 1140 },
            { type: 5, quantity: 0, price: 0 },
            { type: 9, quantity: 2, price: 3060 },
          ]
        }]
      )
    end
  end
end