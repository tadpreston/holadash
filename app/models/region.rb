class Region < ActiveRecord::Base
  attr_accessible :name

  has_many :clubs
  has_many :sys_logs, as: :loggable, dependent: :destroy

  def log_create(actioner)
    sys_logs.new.info(actioner, "#{self.name} was added to the region list.")
  end

  def log_update(actioner)
    sys_logs.new.info(actioner, "#{self.name} was modified.")
  end

end
