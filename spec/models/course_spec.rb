require 'rails_helper'

RSpec.describe Course, type: :model do
  context "Creating a valid Course" do
    it "should save course" do
      expect(build(:course)).to be_valid
    end
  end
  context "Creating an invalid Course" do
    it "should not save course if category is nil" do
      expect(build(:course, category: "")).to be_invalid
    end
  end
end
