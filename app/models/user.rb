class User < ActiveRecord::Base
  attr_accessible :email, :employee_id, :first_name, :last_name, :password_digest, :role, :username
end
