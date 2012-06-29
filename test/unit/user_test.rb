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

  context "generate_token method" do
    setup do
      @user = FactoryGirl.create(:user)
    end

    should "generate a random value in a specified column" do
      assert @user.password_reset_token.blank?
      @user.generate_token(:password_reset_token)
      assert ! @user.password_reset_token.blank?
    end

    should "generate the auth_token when created" do
      assert ! @user.auth_token.blank?
    end
  end

  context "roles= method" do
    should "make array of roles into a string of roles" do
      user = User.new(roles: ["role1", "role2", "role3"])
      assert_equal "role1|role2|role3", user.roles
    end

    should "remove any blank entries from the array" do
      user = User.new(roles: ["","role1","role2","","role3"])
      assert_equal "role1|role2|role3", user.roles
    end
  end

  context "role_symbols method" do
    setup do
      @user = FactoryGirl.create(:user, roles: ["role1","role2"])
    end

    should "return roles as an array of symbols" do
      assert_equal [:role1, :role2], @user.role_symbols
    end
  end

  context "send_password_reset method" do
    setup do
      @user = FactoryGirl.create(:user)
    end

    should "send a reset email" do
      UserMailer.stubs(:deliver)
      @user.send_password_reset
      assert ! @user.password_reset_token.blank?
      assert ! @user.password_reset_sent_at.blank?
    end
  end

  context "normal scope" do
    setup do
      @root_user = FactoryGirl.create(:user, roles: [User::ROLE_ROOT])
      @user = FactoryGirl.create(:user, roles: [User::ROLE_SYSTEM_ADMIN, User::ROLE_REGIONAL_MANAGER])
    end

    should "not return root user" do
      users = User.normal
      assert ! users.include?(@root_user)
    end
  end

end
