Alliance::Application.routes.draw do
  resources :events do
    resources :attendees
  end

  resources :characters do  
    resources :deaths
    resources :xp_tracks
  end

  devise_for :users, :path_prefix => 'd'
  resources :users do
    get :edit_password_form
    put :edit_password
    resources :attendees
    resources :events
    resources :members
    resources :stamp_tracks
    resources :characters do
      resources :deaths 
      resources :xp_tracks
    end
  end

  resources :chapters do
    resources :events
    resources :characters do
      resources :deaths
      resources :xp_tracks
      resources :events #allows application of events to individual characters
    end
    resources :users do
      resources :stamp_tracks
      resources :events #for table of chapters on user page
      resources :characters #to create new users for a given chapter
    end
  end
  
  resources :admins  
  resources :attendees #for creation of
  resources :character_skills #for creation of
  resources :deaths #for creation of
  resources :members #for creation of
  resources :stamp_tracks #for creation of

  root :to => 'users#show'
  # root :to => 'pages#home'

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
