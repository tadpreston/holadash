class SysLog < ActiveRecord::Base
  attr_accessible :actioned_by, :message, :message_type
  belongs_to :loggable, polymorphic: true
end
