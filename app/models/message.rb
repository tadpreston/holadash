class Message < ActiveRecord::Base
  attr_accessible :body, :subject, :author_id, :send_to, :copy_to, :blind_copy_to, :sent_at, :status, :importance

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many   :envelopes, dependent: :destroy

  StatusDraft = 'draft'
  StatusSent = 'sent'

  scope :draft, lambda { |user_id| where(author_id: user_id, status: StatusDraft) }

  def deliver
   raise Exceptions::NoSendToRecipients if self.send_to.blank?

   self.envelopes.create(recipient_id: self.author_id, author_flag: true)

    (self.send_to.split(', ') + self.copy_to.split(', ')).each do |recipient|
      user = User.find_by_display_name(recipient)
      if user
        self.envelopes.create(recipient_id: user.id)
      end
    end
    self.status = StatusSent
    self.sent_at = Time.now
    self.save!
  end

  # TODO - need to find a way for the mark as read to only come through the envelope and not the message. This method should be delete at some point.
  def mark_as_read(user)
    envelope = self.envelopes.where('recipient_id = :id', id: user.id).first
    envelope.mark_as_read if envelope
  end

  def author_name
    author.display_name
  end

  def reply(all_flag = nil)
    raise Exceptions::MessageNotSent unless self.status == StatusSent

    new_send_to = author_name
    new_copy_to = all_flag.blank? ? "" : self.send_to + self.copy_to
    new_subject = "Re: #{self.subject}"
    new_body = "<br /><div class=\"left-border grey\">On #{self.sent_at.strftime("%m/%d/%Y %I:%M %p")} #{author_name} wrote: <br /><br />#{self.body}</div>"

    Message.new(send_to: new_send_to, copy_to: new_copy_to, subject: new_subject, body: new_body)
  end

  def forward
    raise Exceptions::MessageNotSent unless self.status == StatusSent

    new_subject = "Fwd: #{self.subject}"
    new_msg_hdr = "<br /><br />--------Original Message--------<br /><b>Subject:</b> #{self.subject}<br /><b>Date:</b> #{self.sent_at.strftime('%a, %-d %b %Y %H:%M')}<br /><b>To:</b> #{self.send_to}<br/>" + (self.copy_to.blank? ? "" : "<b>Cc:</b> #{self.copy_to}<br />") + "<br /><br />" 
    new_body = new_msg_hdr + self.body

    Message.new(subject: new_subject, body: new_body)
  end
end
