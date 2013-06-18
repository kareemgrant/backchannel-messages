# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    body "What's good my people!!"
    user_id 1
    track_id 1
  end
end
