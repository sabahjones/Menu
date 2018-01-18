require 'rails_helper'

RSpec.describe Order, type: :model do
  context "create a valid order" do
    it "should save order" do
      expect(build(:order, user: build(:user))).to be_valid
    end
    it "should save order if tip is missing" do
      expect(build(:order, tip: "", user: build(:user))).to be_invalid
    end
  end
  context "creating invalid orders" do
    it "should not save if order_num is not an integer" do
      expect(build(:order, order_num: "a", user: build(:user))).to be_invalid
    end
    it "should not save if tip is not an integer" do
      expect(build(:order, tip: "b", user: build(:user))).to be_invalid
    end
    it "should not save if total is not an integer" do
      expect(build(:order, total: "c", user: build(:user))).to be_invalid
    end
    it "should not save order if total > max total" do
      expect(build(:order, total: 10000, user: build(:user))).to be_invalid
    end
    it "should not save order if total < 0" do
      expect(build(:order, total: -1, user: build(:user))).to be_invalid
    end
    it "should not save order if tip < 0" do
      expect(build(:order, total: -1, user: build(:user))).to be_invalid
    end
    it "should not save order if order_num < 0" do
      expect(build(:order, order_num: -1, user: build(:user))).to be_invalid
    end
    it "should not save order if order_num is missing" do
      expect(build(:order, order_num: "", user: build(:user))).to be_invalid
    end
    it "should not save order if total is missing" do
      expect(build(:order, total: "", user: build(:user))).to be_invalid
    end
    it "should not save order if user is missing" do
      expect(build(:order)).to be_invalid
    end
  end
end
