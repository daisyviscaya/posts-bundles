# frozen_string_literal: true

require "rails_helper"

describe Core::Bundles::Calculator do
  describe "when there is no bundle available for the given input" do
    let(:context) { described_class.new(7, "IMG") }

    it "should add bundles_params to context" do
      expect(context.calculate).to be_empty
    end
  end

  describe "when there is a bundle available for the given input" do
    let(:context) { described_class.new(15, "IMG") }

    it "should add bundles_params to context" do
      expect(context.calculate).to eq([1,1])
    end
  end
end
