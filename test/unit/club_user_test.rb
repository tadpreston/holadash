require 'test_helper'

class ClubUserTest < ActiveSupport::TestCase
  should belong_to :club
  should belong_to :user
end
