FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@factory.com" }
    sequence(:employee_id)
    first_name 'Walt'
    last_name  'Disney'
    sequence(:username) { |n| "user#{n}" } 
    password 'supersecret'
    roles [User::ROLE_FRONT_DESK_STAFF]
  end
end
