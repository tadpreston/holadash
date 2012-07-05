class Message < ActiveRecord::Base
  attr_accessible :body, :subject, :author_id

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many   :envelopes, dependent: :destroy
  has_many   :send_tos, class_name: 'Envelope', conditions: 'recipient_type = \'to\''
  has_many   :copy_tos, class_name: 'Envelope', conditions: 'recipient_type = \'cc\''
  has_many   :blind_tos, class_name: 'Envelope', conditions: 'recipient_type = \'bcc\''

  StatusDraft = 'draft'
  StatusSent = 'sent'

  def deliver
    sent_at = Time.now
    envelopes.each do |e|
      e.update_attributes(sent_at: sent_at)
    end
    self.status = StatusSent
    self.save!
  end
end
