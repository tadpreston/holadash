class Message < ActiveRecord::Base
  attr_accessible :body, :author_id, :status, :subject, :to_user_ids

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many   :envelopes, dependent: :destroy
  has_many   :send_tos, class_name: 'Envelope', conditions: 'recipient_type = \'to\''

  StatusDraft = 'draft'
  StatusSent = 'sent'
end
