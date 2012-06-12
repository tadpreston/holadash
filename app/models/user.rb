class User < ActiveRecord::Base
  attr_accessible :email, :employee_id, :first_name, :last_name, :password, :password_confirmation, :roles, :username

  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :username, presence: true, uniqueness: true

  include SysLogger

  ROLE_ROOT = "root"
  ROLE_SYSTEM_ADMIN = "system_admin"
  ROLE_CLUB_OWNER = "club_owner"
  ROLE_REGIONAL_MANAGER = "regional_manager"
  ROLE_CLUB_MANAGER = "club_manager"
  ROLE_SALES_MANAGER = "sales_manager"
  ROLE_SALES_ASSOCIATE = "sales_associate"
  ROLE_PERSONAL_TRAINING_MANAGER = "personal_training_manager"
  ROLE_PERSONAL_TRAINER = "personal_trainer"
  ROLE_MAINTENANCE_MANAGER = "maintenance_manager"
  ROLE_MAINTENANCE_STAFF = "maintenance_staff"
  ROLE_CHILD_CARE_MANAGER = "child_care_manager"
  ROLE_CHILD_CARE_STAFF = "child_care_staff"
  ROLE_FRONT_DESK_MANAGER = "front_desk_manager"
  ROLE_FRONT_DESK_STAFF = "front_desk_staff"

  ROLES = [ROLE_SYSTEM_ADMIN, ROLE_CLUB_OWNER, ROLE_REGIONAL_MANAGER, ROLE_CLUB_MANAGER, ROLE_SALES_MANAGER, ROLE_SALES_ASSOCIATE, ROLE_PERSONAL_TRAINING_MANAGER, ROLE_PERSONAL_TRAINER, ROLE_MAINTENANCE_MANAGER, ROLE_MAINTENANCE_STAFF, ROLE_CHILD_CARE_MANAGER, ROLE_CHILD_CARE_STAFF, ROLE_FRONT_DESK_MANAGER, ROLE_FRONT_DESK_STAFF]

  default_scope order("employee_id asc")
  scope :normal, where(["roles not like ?", "%#{ROLE_ROOT}%"])

  def full_name
    "#{first_name} #{last_name}"
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def roles=(roles_array)
    roles_array = roles_array.delete_if {|r| r.blank?}
    str = roles_array.collect {|r| r}.join('|')
    write_attribute :roles, str
  end

  def role_symbols
    roles.split('|').collect {|r| r.to_sym}
  end

  def log_login
    sys_logs.new.info(full_name, "#{self.full_name} logged in successfully.")
  end

  def log_logout
    sys_logs.new.info(full_name, "#{self.full_name} logged out.")
  end
end
