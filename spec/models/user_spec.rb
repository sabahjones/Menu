require 'rails_helper'

RSpec.describe User, type: :model do
    context "valid user: " do
      it "should save user" do
        expect(build(:user)).to be_valid
      end
      it "should encrypt user password" do
        expect(build(:user).password_digest.present?).to eq(true)
      end
      it "will downcase email entry" do
        expect(create(:user, email:"CAPS@EMAIL.COM").email).to eq("caps@email.com")
      end
    end
    context "invalid user: " do
      it "should not save if name is blank" do
        expect(build(:user, name: "")).to be_invalid
      end
      it "should not save if password is blank" do
        expect(build(:user, password: "")).to be_invalid
      end
      it "should not save if email is blank" do
        expect(build(:user, email: "")).to be_invalid
      end
      it "should not save if email pattern is incorrect" do
        expect(build(:user, email: "invalid@email")).to be_invalid
      end
      it "should not save if name is less than 2 characters" do
        expect(build(:user, name: "J")).to be_invalid
      end
      it "should not save if name is greater than 10 characters" do
        expect(build(:user, name: "preventalongname")).to be_invalid
      end
      it "should not save an email greater than 40 characters" do
        expect(build(:user, name: "thisemailistoolongfordatabase@toolong.com")).to be_invalid
      end
      it "should enforce unique emails in db" do
        expect(create(:user)).to be_valid
        expect(build(:user, :clark, email:"bruce@email.com")).to be_invalid
      end
    end
end
