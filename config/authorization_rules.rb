authorization do
  role :guest do
    title "Guest"
    description "The role all user have before they log in"
    has_permission_on :welcome, to: :index
  end

  role :system_admin do
    title "System Administrator"
    description "The highest role that can be assigned to a user in the system"
    includes :guest
    has_permission_on :administration, to: [:index]
    has_permission_on :administration_users, to: [:index,:show,:new,:create,:edit,:update]
    has_permission_on :administration_regions, to: [:index, :show, :new, :create, :edit, :update]
    has_permission_on :administration_clubs, to: [:index, :show, :new, :create, :edit, :update]
  end

  role :root do
    title "Root"
    description "The top level role that should not be given to anyone except the root user, instead use system_admin"
    has_omnipotence
  end
end
