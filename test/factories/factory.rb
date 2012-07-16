FactoryGirl.define do
  factory :user, aliases: [:author, :recipient] do
    sequence(:email) { |n| "email#{n}@factory.com" }
    sequence(:employee_id) { |n| "1000#{n}" }
    first_name 'Walt'
    last_name  'Disney'
    sequence(:username) { |n| "user#{n}" } 
    password 'supersecret'
    roles [User::ROLE_FRONT_DESK_STAFF]
  end

  factory :envelope do
    recipient
  end

  factory :message do
    author
    send_to 'Bob Jones, Heidi Baker,'
    copy_to 'Mike Bickle,'
    subject 'This is a subject'
    body    'this is the body of the message'
  end

end
