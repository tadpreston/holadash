require 'test_helper'

class SysLogTest < ActiveSupport::TestCase
  should belong_to(:loggable)

  context 'sys log methods' do
    should 'add_log method' do
      assert SysLog.new.add_log('TEST', 'The actioner', 'This is a message')
    end
  end
end
