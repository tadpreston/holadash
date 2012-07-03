class Message < ActiveRecord::Base
  attr_accessible :body, :from_id, :status, :subject
end
