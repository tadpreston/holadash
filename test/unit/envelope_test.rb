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
    setup do
      @user = FactoryGirl.create(:user, first_name: 'Bill', last_name: 'Johnson')
      @message = FactoryGirl.create(:message, author: @user)
      User.stubs(:find_by_display_name).returns(FactoryGirl.create(:user))
      @message.deliver
      @envelope = @message.envelopes.first
    end

    context 'from method' do
      should 'return the authors full name' do
        assert_equal @user.full_name, @envelope.from
      end
    end

    context 'sent_at method' do
      should 'return the sent_at value' do
        assert_equal @message.sent_at.strftime('%m%d%Y %H%M'), @envelope.sent_at.strftime('%m%d%Y %H%M')
      end
    end

    context 'is_read? method' do
      should 'return false' do
        assert ! @envelope.is_read?
      end

      should 'return true' do
        @envelope.mark_as_read
        assert @envelope.is_read?
      end
    end

    context 'mark_as_read method' do
      should 'set the read flag to true' do
        @envelope.mark_as_read
        assert @envelope.is_read?
      end
    end
  end
end
