require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  should belong_to(:author).class_name('User')
  should have_many(:receipients)
  should have_many(:to_users).through(:receipients)
  should have_many(:copied_receipients)
  should have_many(:cc_users).through(:copied_receipients)
  should have_many(:blind_receipients)
  should have_many(:bcc_users).through(:blind_receipients)

  context 'The factory' do
    setup do
      @message = FactoryGirl.create(:message)
    end

    should 'create a message with an author' do
      assert @message.author, 'no author was created'
    end

    should 'create the receipients' do
      assert !@message.to_users.empty?, 'no to_users'
    end

    should 'create the copied_receipients' do
      assert !@message.to_users.empty?, 'no to_users'
    end

    should 'create the blind_receipients' do
      assert !@message.to_users.empty?, 'no to_users'
    end

  end
end
