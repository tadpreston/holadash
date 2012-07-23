class Region < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true

  include SysLogger

  has_many :clubs

end
