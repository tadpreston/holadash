class User < ActiveRecord::Base
  attr_accessible :email, :employee_id, :first_name, :last_name, :password, :password_confirmation, :roles, :username, :club_ids

  has_secure_password

  before_create { generate_token(:auth_token) }

  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :username, presence: true, uniqueness: true

  include SysLogger

  has_many :club_users
  has_many :clubs, through: :club_users
  has_many :messages, foreign_key: :author_id
  has_many :envelopes, foreign_key: :recipient_id

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
  AdminRoles = [ROLE_ROOT, ROLE_SYSTEM_ADMIN, ROLE_CLUB_OWNER, ROLE_REGIONAL_MANAGER, ROLE_CLUB_MANAGER]

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

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def is_admin?
    is_admin = false
    self.roles.split('|').each do |r|
      is_admin = true if AdminRoles.include?(r)
    end
    is_admin
  end
end
