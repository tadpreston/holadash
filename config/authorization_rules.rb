authorization do
  role :site_admin do
    has_permission_on :users, to: [:index,:show,:new,:create,:edit,:update]
  end

  role :root do
    includes :site_admin
  end
end
