class Message < ActiveRecord::Base
  attr_accessible :body, :subject, :author_id, :send_to, :copy_to, :blind_copy_to, :sent_at

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many   :envelopes, dependent: :destroy

  StatusDraft = 'draft'
  StatusSent = 'sent'

  scope :belongs_to_user, lambda { |user_id| where(author_id: user_id) }
  scope :draft, where(status: StatusDraft)
  scope :sent, where(status: StatusSent)

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
    envelope.mark_as_read if envelope
  end

  def author_name
    author.display_name
  end

  def reply(all_flag = nil)
    new_send_to = author_name
    new_copy_to = all_flag.blank? ? "" : self.send_to + self.copy_to
    new_subject = "Re: #{self.subject}"
    new_body = "<br /><div class=\"left-border grey\">On #{self.updated_at.strftime("%m/%d/%Y %I:%M %p")} #{author_name} wrote: <br /><br />#{self.body}</div>"

    Message.new(send_to: new_send_to, copy_to: new_copy_to, subject: new_subject, body: new_body)
  end

end
