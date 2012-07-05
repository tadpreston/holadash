class Envelope < ActiveRecord::Base
  attr_accessible :message_id, :read_flag, :recipient_id, :recipient_type, :trash_flag
end
