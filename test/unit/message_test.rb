require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  should belong_to(:author).class_name('User')
  should have_many(:envelopes).dependent(:destroy)

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
  end

  context 'sent scope' do
    setup do
      FactoryGirl.create(:sent_message_with_envelopes)
    end

    should 'return all sent messages' do
      assert_equal 4, Message.sent.count
    end
  end

  context 'deliver method' do
    setup do
    end

    should 'create envelopes and set status to sent' do
      author = FactoryGirl.create(:user, first_name: 'Author', last_name: 'Person')
      message = FactoryGirl.create(:message, author: author)
      user = FactoryGirl.create(:user)
      User.stubs(:find_by_display_name).returns(user)

      message.deliver
      message.reload
      recipients = message.send_to.split(', ') + (message.copy_to.split(', ') << message.author_name)
      assert_equal recipients.count, message.envelopes.count  # test to see if there are the same number of envelopes as there are recipients
      assert_equal message.status, Message::StatusSent # Check to see if the status is set to sent
      assert_equal message.author, Envelope.belongs_to_user(author.id).first.recipient # make sure the author envelope gets created.
    end

    should 'throw an exception because there are no send_to recipients' do
      message = FactoryGirl.create(:message, send_to: '')
      assert_raise(Exceptions::NoSendToRecipients) { message.deliver }
    end
  end

  context 'mark_as_read method' do
    should 'set the read flag to true' do
      message = FactoryGirl.create(:sent_message_with_envelopes)
      envelope = message.envelopes.first

      message.mark_as_read envelope.recipient
      envelope.reload
      assert envelope.read_flag
    end
  end

  context 'author_name method' do
    should 'return the authors display name' do
      message = FactoryGirl.create(:message)
      assert_equal message.author.display_name, message.author_name
    end
  end

  context 'reply method' do
    should 'return a new message with only sender as recipient' do
      message = FactoryGirl.create(:sent_message)
      new_message = message.reply

      assert_equal new_message.send_to, message.author_name
      assert new_message.copy_to.blank?
      assert_equal new_message.subject[0..3], 'Re: '
    end

    should 'return a new message with all recipients' do
      message = FactoryGirl.create(:sent_message)
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
      message = FactoryGirl.create(:sent_message)
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

  context 'send_to_trash method' do
    should 'set trash_flag to true' do
      message = FactoryGirl.create(:sent_message)
      message.send_to_trash
      assert message.trash_flag
    end
  end

  context 'delete method' do
    should 'set delete_flag to true' do
      message = FactoryGirl.create(:sent_message)
      message.delete
      assert message.delete_flag
    end
  end
end
