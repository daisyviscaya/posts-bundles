require "rails_helper"

describe Bundles::Quantify do
  describe "when input is invalid" do
    let(:params) do
      { bundles_params: [{ quantity: 1.2, format: "IMG" }] }
    end
    let(:context) { described_class.call(params) }

    it "should fail" do
      expect(context).to be_a_failure
    end

    it "should not add resulted_bundles to context" do
      expect(context.resulted_bundles).to be_nil
    end
  end

  describe "when input has the correct format and with VALID bundles" do
    let(:params) do
      { bundles_params: [ quantity: 20, format: "IMG" ] }
    end
    let(:context) { described_class.call(params) }
    it "should succeed" do
      expect(context).to be_a_success
    end

    it "should add resulted_bundles to context" do
      expect(context.resulted_bundles).to be_present
    end

    it "should have correct values for context.resulted_bundles" do
      expect(context.resulted_bundles).to eq(
        [{ quantity: 20, format: "IMG", bundle_combination: [0, 2] }]
      )
    end
  end


  describe "when order can't be satisfied with the allowable bundle combinations" do
    let(:params) do
      # allowable bundle for IMG is only multiples of 5 and 10
      { bundles_params: [ quantity: 12, format: "IMG" ] }
    end
    let(:context) { described_class.call(params) }

    it "should succeed" do
      expect(context).to be_a_success
    end

    it "should add resulted_bundles to context" do
      expect(context.resulted_bundles).to be_present
    end

    it "should return empty bundle_combination" do
      expect(context.resulted_bundles).to eq(
        [{ quantity: 12, format: "IMG", bundle_combination: [] }]
      )
    end
  end
end