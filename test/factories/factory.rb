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

    factory :author_envelope do
      author_flag true
    end
  end

  factory :message do
    author

    send_to 'Test Person, Test Person2'
    copy_to 'Copied Person'
    subject 'This is a subject'
    body    'This is the body of the message'

    factory :sent_message do

      sent_at 10.minutes.ago
      status  Message::StatusSent

      factory :sent_message_with_envelopes do
        ignore do
          envelope_count 3
        end

        after(:create) do |message, evaluator|
          FactoryGirl.create(:author_envelope, recipient: message.author, message: message)
          FactoryGirl.create_list(:envelope, evaluator.envelope_count, message: message)
        end
      end
    end
  end

end
