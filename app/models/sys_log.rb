class SysLog < ActiveRecord::Base
  attr_accessible :actioned_by, :message, :message_type
  belongs_to :loggable, polymorphic: true

  TYPE_INFO = "INFO"
  TYPE_WARNING = "WARNING"
  TYPE_ERROR = "ERROR"
  TYPE_DEBUG = "DEBUG"


  def add_log(message_type, actioner, message)
    self.message_type = message_type
    self.message = message
    self.actioned_by = actioner
    self.save
  end

end
