# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_type, :class => 'EventTypes' do
    name "MyString"
    value 1
  end
end
