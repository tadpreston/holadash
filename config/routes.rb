Portal::Application.routes.draw do

  resources :sessions
  resources :password_resets
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'access_denied', to: 'sessions#access_denied', as: 'access_denied'
  get 'inbox', to: 'inbox#index', as: 'inbox'
  get 'inbox/refresh', to: 'inbox#refresh', as: 'inbox_refresh'
  put 'envelopes/:envelope_id/trash', to: 'envelopes#trash', as: 'envelope_trash'
  put 'envelopes/:envelope_id/delete', to: 'envelopes#delete', as: 'envelope_delete'
  put 'envelopes/:envelope_id/mark_important', to: 'envelopes#mark_important', as: 'envelope_mark_important'

  resources :messages do
    get 'reply'
    get 'forward'
    put 'trash'
    put 'delete'
  end
  resources :users do
    collection do
      get 'search'
    end
  end

  namespace :administration do
    resources :regions do
      resources :clubs
    end
    resources :users

    root to: 'home#index'
  end

  root to: 'welcome#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
