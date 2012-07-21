# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "test@test.com"
    first_name "hello"
    last_name "world"
    password "txt@1234"
    password_confirmation "txt@1234"
  end
end
