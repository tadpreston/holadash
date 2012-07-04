class UserMessage < ActiveRecord::Base
  attr_accessible :message_id, :user_id

  belongs_to :user
  belongs_to :message
end
