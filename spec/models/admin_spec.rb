require 'rails_helper'

RSpec.describe Admin, type: :model do
  context "create a valid admin" do
    it "should save admin" do
      expect(build(:admin, user: build(:user))).to be_valid
    end
  end
  context "Create an invalid admin" do
    it "should not save admin without a user" do
      expect(build(:admin)).to be_invalid
    end
  end
end
