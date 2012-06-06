require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of :email
  should validate_presence_of :username
  should validate_uniqueness_of :email
  should validate_uniqueness_of :username

  context "full_name method" do
    setup do
      @user = FactoryGirl.create(:user)
    end

    should "return the full name of the user" do
      assert_equal "#{@user.first_name} #{@user.last_name}", @user.full_name
    end
  end
end
