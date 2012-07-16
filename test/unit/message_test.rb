require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  should belong_to(:author).class_name('User')
  should have_many(:envelopes).dependent(:destroy)

  context 'The factory' do
    setup do
      @message = FactoryGirl.create(:message)
    end

    should 'create a message with an author' do
      assert @message.author, 'no author was created'
    end

  end

  context 'model scopes' do
    setup do
      @user = FactoryGirl.create(:user)
      3.times do
        FactoryGirl.create(:message, author: @user)
        FactoryGirl.create(:message)
      end
    end

    context 'belongs_to_user scope' do
      should 'return all messages the user has authored' do
        assert_equal 3, Message.belongs_to_user(@user).count
      end

      should 'not return any messages' do
        usr = FactoryGirl.create(:user)
        assert_equal 0, Message.belongs_to_user(usr).count
      end
    end

    context 'draft scope' do
      should 'return all draft messages' do
        assert_equal 6, Message.draft.count
      end
    end

    context 'sent scope' do
      setup do
        3.times do
          FactoryGirl.create(:message, status: Message::StatusSent)
        end
      end

      should 'return all draft messages' do
        assert_equal 3, Message.sent.count
      end
    end

    context 'deliver method' do
      should 'create envelopes and set status to sent' do
        @message = FactoryGirl.create(:message)
        user = FactoryGirl.create(:user, first_name: 'Recip', last_name: 'Person')
        User.stubs(:find_by_display_name).returns(user)

        @message.deliver
        @message.reload
        recipients = @message.send_to.split(', ') + @message.copy_to.split(', ')
        assert_equal recipients.count, @message.envelopes.count
        assert_equal @message.status, Message::StatusSent
      end

      should 'throw an exception because there are no send_to recipients' do
        message = FactoryGirl.create(:message, send_to: '')

        assert_raise(Exceptions::NoSendToRecipients) { message.deliver }
      end
    end
  end

  context 'author_name method' do
    should 'return the authors display name' do
      user = FactoryGirl.create(:user)
      message = FactoryGirl.create(:message, author: user)
      assert_equal user.display_name, message.author_name
    end
  end

  context 'reply method' do
    should 'return a new message with only sender as recipient' do
      user = FactoryGirl.create(:user, first_name: 'John', last_name: 'Smith')
      message = FactoryGirl.create(:message, author: user, status: Message::StatusSent, sent_at: Time.now)
      new_message = message.reply

      assert_equal new_message.send_to, user.display_name
      assert new_message.copy_to.blank?
      assert_equal new_message.subject[0..3], 'Re: '
    end

    should 'return a new message with all recipients' do
      user = FactoryGirl.create(:user, first_name: 'John', last_name: 'Smith')
      message = FactoryGirl.create(:message, author: user, status: Message::StatusSent, sent_at: Time.now)
      new_message = message.reply(true)

      assert ! new_message.copy_to.blank?
    end

    should 'return an exception if message has not been sent' do
      message = FactoryGirl.create(:message)
      assert_raise(Exceptions::MessageNotSent) { message.reply }
    end
  end

  context 'forward method' do
    should 'return a new message with no recipients' do
      user = FactoryGirl.create(:user, first_name: 'John', last_name: 'Smith')
      message = FactoryGirl.create(:message, author: user, status: Message::StatusSent, sent_at: Time.now)
      new_message = message.forward

      assert new_message.send_to.blank?
      assert new_message.copy_to.blank?
      assert_equal new_message.subject[0..4], 'Fwd: '
    end

    should 'return an exception if message has not been sent' do
      message = FactoryGirl.create(:message)
      assert_raise(Exceptions::MessageNotSent) { message.reply }
    end
  end
end
