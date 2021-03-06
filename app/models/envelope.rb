class Envelope < ActiveRecord::Base
  attr_accessible :message_id, :read_flag, :recipient_id, :trash_flag, :author_flag, :delete_flag, :importance_flag

  belongs_to :message
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id

  scope :belongs_to_user, lambda { |user_id| where(recipient_id: user_id) }
  scope :inbox, where(trash_flag: false, author_flag: false)
  scope :unread, where(read_flag: false)
  scope :trash, where(trash_flag: true, delete_flag: false)
  scope :sent, where(trash_flag: false, author_flag: true)
  scope :order_by_sent_at, joins(:message).order('messages.sent_at ASC')

  def from
    message.author.full_name
  end

  def sent_at
    message.sent_at
  end

  def is_read?
    self.read_flag
  end

  def is_trash?
    self.trash_flag
  end

  def is_deleted?
    self.delete_flag
  end

  def mark_as_read
    self.update_attributes(read_flag: true)
  end

  def trash
    self.update_attributes(trash_flag: true)
  end

  def delete
    self.update_attributes(delete_flag: true)
  end

  def mark_important
    self.update_attributes(importance_flag: true)
  end

  def is_important?
    self.importance_flag
  end
end
