class Club < ActiveRecord::Base
  attr_accessible :address, :name, :region_id

  belongs_to :region
end
