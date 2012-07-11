class Message < ActiveRecord::Base
  attr_accessible :body, :subject, :author_id, :send_to, :copy_to, :blind_copy_to

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many   :envelopes, dependent: :destroy

  StatusDraft = 'draft'
  StatusSent = 'sent'

  def deliver
    (self.send_to.split(', ') + self.copy_to.split(', ')).each do |recipient|
      user = User.find_by_display_name(recipient)
      if user
        self.envelopes.create(recipient_id: user.id)
      end
    end
    self.status = StatusSent
    self.save!
  end

  def mark_as_read(user)
    envelope = self.envelopes.where('recipient_id = :id', id: user.id).first
    envelope.mark_as_read
  end

end
