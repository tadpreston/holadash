class Message < ActiveRecord::Base
  attr_accessible :body, :author_id, :status, :subject, :to_user_ids

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :receipients
  has_many :to_users, through: :receipients, source: :user
  has_many :copied_receipients
  has_many :cc_users, through: :copied_receipients, source: :user
  has_many :blind_receipients
  has_many :bcc_users, through: :blind_receipients, source: :user

  StatusDraft = 'draft'
  StatusSent = 'sent'
end
