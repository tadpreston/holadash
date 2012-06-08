authorization do
  role :guest do
    has_permission_on :welcome, to: :index
  end

  role :site_admin do
    includes :guest
    has_permission_on :users, to: [:index,:show,:new,:create,:edit,:update]
  end

  role :root do
    includes :site_admin
  end
end
