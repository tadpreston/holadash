class ClubUser < ActiveRecord::Base
  attr_accessible :club_id, :user_id

  belongs_to :club
  belongs_to :user

end
