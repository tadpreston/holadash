require 'test_helper'

class EnvelopeTest < ActiveSupport::TestCase
  should belong_to(:message)
  should belong_to(:recipient).class_name('User')


  context 'Envelope scopes' do
    setup do
      @user = FactoryGirl.create(:user)
      3.times do
        FactoryGirl.create(:envelope, recipient: @user)
        FactoryGirl.create(:envelope)
        FactoryGirl.create(:envelope, read_flag: true)
      end
    end

    context 'belongs_to_user' do
      should 'return only a given users envelopes' do
        assert_equal 3, Envelope.belongs_to_user(@user.id).count
      end
    end

    context 'unread' do
      should 'return only unread envelopes' do
        assert_equal 6, Envelope.unread.count
      end
    end
  end

  context 'envelope class' do
    context 'with a message' do
      setup do
        @message = FactoryGirl.create(:sent_message_with_envelopes)
        @envelope = @message.envelopes.first
        User.stubs(:find_by_display_name).returns(FactoryGirl.create(:user))
      end

      context 'from method' do
        should 'return the authors full name' do
          assert_equal @message.author.full_name, @envelope.from
        end
      end

      context 'sent_at method' do
        should 'return the sent_at value' do
          assert_equal @message.sent_at.strftime('%m%d%Y %H%M'), @envelope.sent_at.strftime('%m%d%Y %H%M')
        end
      end
    end

    context 'is_read? method' do
      should 'return false' do
        assert ! FactoryGirl.create(:envelope).is_read?
      end

      should 'return true' do
        assert FactoryGirl.create(:read_envelope).is_read?
      end
    end

    context 'mark_as_read method' do
      should 'set the read flag to true' do
        envelope = FactoryGirl.create(:envelope)
        envelope.mark_as_read
        assert envelope.is_read?
      end
    end

    context 'trash method' do
      should 'set the trash flag to true' do
        envelope = FactoryGirl.create(:envelope)
        envelope.trash
        assert envelope.trash_flag
      end
    end

    context 'is_trash? method' do
      should 'return false' do
        assert ! FactoryGirl.create(:envelope).is_trash?
      end

      should 'return true' do
        assert FactoryGirl.create(:trash_envelope).is_trash?
      end
    end
  end
end
