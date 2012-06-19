module SysLogger

  ActiveRecord::Base.has_many :sys_logs, as: :loggable, dependent: :destroy

  def method_missing(method, *args)
    if method.to_s =~ /^log_/  # if the method called is a log method
      sys_logs.new.add_log method.slice(/[^_]+$/).upcase, args[0], args[1]
    else
      super
    end
  end
end
