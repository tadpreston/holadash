class SysLog < ActiveRecord::Base
  attr_accessible :actioned_by, :message, :message_type
  belongs_to :loggable, polymorphic: true

  TYPE_INFO = "INFO"
  TYPE_WARNING = "WARNING"
  TYPE_ERROR = "ERROR"
  TYPE_DEBUG = "DEBUG"


  def info(actioner, message)
    save_log_details(TYPE_INFO, actioner, message)
  end
  
  def warning(actioner, message)
    save_log_details(TYPE_WARNING, actioner, message)
  end
  
  def error(actioner, message)
    save_log_details(TYPE_ERROR, actioner, message)
  end
  
  def debug(actioner, message)
    save_log_details(TYPE_DEBUG, actioner, message)
  end
  
  private
  
  def save_log_details(message_type, actioner, message)
    self.message_type = message_type
    self.message = message
    self.actioned_by = actioner
    self.save
  end

end
