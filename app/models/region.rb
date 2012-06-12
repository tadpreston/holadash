class Region < ActiveRecord::Base
  attr_accessible :name

  include SysLogger

  has_many :clubs

end
