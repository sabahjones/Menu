require 'rails_helper'

RSpec.describe Purchase, type: :model do
  context "valid purchase: " do
    it "should save a valid purchase" do
      expect(build(:purchase, order: build(:order), food: build(:food))).to be_valid
    end
  end
  context "Invalid purchases: " do
    it "should not save a valid purchase without an order" do
      expect(build(:purchase, food: build(:food))).to be_invalid
    end
    it "should not save a valid purchase without a food" do
      expect(build(:purchase, order: build(:order))).to be_invalid
    end
  end
end
