require "rails_helper"

describe Bundles::Validate do
  describe "when input is not an integer" do
    # "not_int" string is invalid input
    let(:context) { described_class.call( bundles_input: "not_int IMG" ) }

    it "should fail" do
      expect(context).to be_a_failure
    end

    it "should add bundles_params to context" do
      expect(context.bundles_params).to be_empty
    end

    it "should return an error" do
      expect(context.error).to eq("Invalid input format. Please try again.")
    end
  end

  describe "when input is not a valid format type" do
    # IMAGES is not a valid format type
    let(:context) { described_class.call( bundles_input: "10 IMAGES" ) }

    it "should fail" do
      expect(context).to be_a_failure
    end

    it "should add bundles_params to context" do
      expect(context.bundles_params).to be_empty
    end

    it "should return an error" do
      expect(context.error).to eq("Invalid input format. Please try again.")
    end
  end

  describe "when input has the correct format" do
    let(:context) { described_class.call(bundles_input: "10 IMG") }
    it "should succeed" do
      expect(context).to be_a_success
    end

    it "should add bundles_params to context" do
      expect(context.bundles_params).to be_present
    end

    it "should have correct values for context.bundles_params" do
      expect(context.bundles_params).to eq([{ quantity: 10, format: "IMG" }])
    end
  end
end