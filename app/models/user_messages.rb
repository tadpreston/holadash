class UserMessages < ActiveRecord::Base
  attr_accessible :message_id, :umtype, :user_id
end
