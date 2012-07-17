require 'test_helper'

class ClubTest < ActiveSupport::TestCase
  should belong_to :region

  should have_many(:club_users)
  should have_many(:users).through(:club_users)
end
