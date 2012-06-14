authorization do
  role :guest do
    has_permission_on :welcome, to: :index
  end

  role :system_admin do
    includes :guest
    has_permission_on :administration, to: [:index]
    has_permission_on :administration_users, to: [:index,:show,:new,:create,:edit,:update]
    has_permission_on :administration_regions, to: [:index, :show, :new, :create, :edit, :update]
    has_permission_on :administration_clubs, to: [:index, :show, :new, :create, :edit, :update]
  end

  role :root do
    includes :system_admin
  end
end
