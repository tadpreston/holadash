class Envelope < ActiveRecord::Base
  attr_accessible :message_id, :read_flag, :recipient_id, :trash_flag

  belongs_to :message
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id

  SendTo = 'to'
  CopyTo = 'cc'
  BlindCopyTo = 'bcc'

  def from
    message.author.full_name
  end

  def sent
    message.sent_at
  end

  def is_read?
    self.read_flag
  end

  def is_trash?
    self.trash_flag
  end

  def mark_as_read
    self.update_attributes(read_flag: true)
  end
end
