require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  should belong_to(:author).class_name('User')
  should have_many(:envelopes).dependent(:destroy)
  should have_many(:send_tos).class_name('Envelope').conditions('recipient_type = \'to\'')
  should have_many(:copy_tos).class_name('Envelope').conditions('recipient_type = \'cc\'')
  should have_many(:blind_tos).class_name('Envelope').conditions('recipient_type = \'bcc\'')

  context 'The factory' do
    setup do
      @message = FactoryGirl.create(:message)
    end

    should 'create a message with an author' do
      assert @message.author, 'no author was created'
    end

    should 'create the send_tos' do
      assert !@message.send_tos.empty?, 'no send_tos'
    end

  end
end
