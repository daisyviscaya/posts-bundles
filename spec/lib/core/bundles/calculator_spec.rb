require "rails_helper"

describe Core::Bundles::Calculator do
  describe "when there is no bundle available for the given input" do
    let(:context) { described_class.new(7, "IMG") }

    it "should return an empty array of bundle combinations" do
      expect(context.calculate).to be_empty
    end
  end

  describe "when there is a bundle available for the given input" do
    let(:context) { described_class.new(15, "IMG") }

    it "should return the cheapest bundle combination available" do
      expect(context.calculate).to eq([1,1])
    end
  end
end
