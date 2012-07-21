# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chapter do
    owner "MyString"
    email "MyString@test.com"
    name "MyStringPlace"
    location "MS"
  end
end
