require "rails_helper"

describe Bundles::Organizers::Calculate do
  it "runs the right interactors" do
    expect(described_class.organized).to eq(
      [
        Bundles::Validate,
        Bundles::Quantify,
        Bundles::Prepare,
        Bundles::Print
      ]
    )
  end

  describe "when input is missing or invalid" do
    let(:context) { described_class.call() }

    it "should fail" do
      expect(context).to be_a_failure
    end
  end

  describe "when input is valid" do
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

    it "should add body to context" do
      expect(context.body).to be_present
    end

    it "should add bundles_params to context" do
      expect(context.bundles_params).to be_present
    end

  end
end