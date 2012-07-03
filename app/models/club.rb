class Club < ActiveRecord::Base
  attr_accessible :address, :name

  include SysLogger

  belongs_to :region

  has_many :club_users
  has_many :users, through: :club_users
end
