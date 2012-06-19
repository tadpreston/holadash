module SysLogger

  ActiveRecord::Base.has_many :sys_logs, as: :loggable, dependent: :destroy

  def method_missing(method, *args)
    if method.to_s =~ /^log_/  # if the method called is a log method
      log_type = method.slice(/[^_]+$/)
      if %w[info error warning debug].include? log_type
        sys_logs.new.send "#{log_type}", args[0], args[1]
      else
        sys_logs.new.info(args[0], args[1])
      end
    else
      super
    end
  end
end
