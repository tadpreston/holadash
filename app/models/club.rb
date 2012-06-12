class Club < ActiveRecord::Base
  attr_accessible :address, :name

  include SysLogger

  belongs_to :region
end
