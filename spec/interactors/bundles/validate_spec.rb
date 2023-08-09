require "rails_helper"

describe Bundles::Validate do
  describe "when input is invalid" do
    let(:params) do
      { bundles_input: "hey i just met u" }
    end
    let(:context) { described_class.call(params) }

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
    let(:params) do
      { bundles_input: "12 img" }
    end
    let(:context) { described_class.call(params) }
    it "should succeed" do
      expect(context).to be_a_success
    end

    it "should add bundles_params to context" do
      expect(context.bundles_params).to be_present
    end

    it "should have correct values for context.bundles_params" do
      expect(context.bundles_params).to eq([{ quantity: 12, format: "IMG" }])
    end
  end
end