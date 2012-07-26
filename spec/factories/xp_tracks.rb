# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :xp_track do
    attendee_id 2
    end_xp 30
    reason "test reason"
    start_xp 0
    start_build 15
    end_build 25
  end
end
