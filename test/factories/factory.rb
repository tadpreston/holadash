FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:email) { |n| "email#{n}@factory.com" }
    sequence(:employee_id) { |n| "1000#{n}" }
    first_name 'Walt'
    last_name  'Disney'
    sequence(:username) { |n| "user#{n}" } 
    password 'supersecret'
    roles [User::ROLE_FRONT_DESK_STAFF]
  end

  factory :receipient do
    association :user
  end

  factory :copied_receipient do
    association :user
  end

  factory :blind_receipient do
    association :user
  end

  factory :message do
    author
    subject 'This is a subject'
    body    'this is the body of the message'

    receipients { |r| [r.association(:receipient)] }
    copied_receipients { |r| [r.association(:copied_receipient)] }
    blind_receipients { |r| [r.association(:blind_receipient)] }
  end

end
