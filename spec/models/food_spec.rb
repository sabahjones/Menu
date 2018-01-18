require 'rails_helper'

RSpec.describe Food, type: :model do
  context "valid food items" do
    it "should save a food item" do
      expect(build(:food, course: build(:course), admin: build(:admin))).to be_valid
    end
  end
  context "invalid food items" do
    it "should not save food without an admin" do
      expect(build(:food, course: build(:course))).to be_invalid
    end
    it "should not save food without a course" do
      expect(build(:food, admin: build(:admin))).to be_invalid
    end
    it "should not save food without a name" do
      expect(build(:food, name: "", course: build(:course), admin: build(:admin))).to be_invalid
    end
    it "should not save food without a description" do
      expect(build(:food, description: "", course: build(:course), admin: build(:admin))).to be_invalid
    end
    it "should not save food without a price" do
      expect(build(:food, price: "", course: build(:course), admin: build(:admin))).to be_invalid
    end
    it "should not save food with a very short name" do
      expect(build(:food, name: "a", course: build(:course), admin: build(:admin))).to be_invalid
    end
    it "should not save food with a very short description" do
      expect(build(:food, description: "b", course: build(:course), admin: build(:admin))).to be_invalid
    end
    it "should not save food with a negative price" do
      expect(build(:food, price: -2, course: build(:course), admin: build(:admin))).to be_invalid
    end
    it "should not save food with a price above 999.99 price" do
      expect(build(:food, price: 1000, course: build(:course), admin: build(:admin))).to be_invalid
    end
    it "should not save food if price is a string" do
      expect(build(:food, price: "abcd", course: build(:course), admin: build(:admin))).to be_invalid
    end
  end
end
