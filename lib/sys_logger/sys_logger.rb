module SysLogger

  ActiveRecord::Base.has_many :sys_logs, as: :loggable, dependent: :destroy

  def log_create(actioner)
    sys_logs.new.info(actioner, message)
  end

  def log_update(actioner, message)
    sys_logs.new.info(actioner, message)
  end

  def log_error(actioner, message)
    sys_logs.new.error(actioner, message)
  end

  def log_warning(actioner, message)
    sys_logs.new.warning(actioner, message)
  end

  def log_debug(actioner, message)
    sys_logs.new.debug(actioner, message)
  end
end
