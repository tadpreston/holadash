class Envelope < ActiveRecord::Base
  attr_accessible :message_id, :read_flag, :recipient_id, :recipient_type, :trash_flag

  belongs_to :message
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
end
