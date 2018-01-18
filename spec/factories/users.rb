FactoryGirl.define do
  factory :user do
    name "Bruce"
    email "bruce@email.com"
    password "password"
    password_confirmation "password"
  end
  trait :clark do
    name "Clark"
    email "clark@email.com"
  end
end
