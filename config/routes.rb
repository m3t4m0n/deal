Rails.application.routes.draw do
  get 'register/info1'

  get 'register/info2'

  get 'visitor/main'
  
  resources :posts

# root :to => 'home#intro'
# get '/post' => 'posts#index'
# get '/intro' => 'home#intro'

  devise_for :users, :controllers => { omniauth_callbacks: 'user/omniauth_callbacks'}
  get '/home/intro'
  devise_for :users
  as :user do
    get 'users/show' => 'devise/registrations#show'
  end

  root 'home#index'
  
  get '/home/index'
  get '/home/generic'
  get '/home/elements'

# get '/home/intro'
  get '/board'=>'posts#index'
  get '/write_post' => 'posts#new'

  #hashtags
  get '/posts/hashtag/:name' => 'posts#hashtags'
  #댓글 달기
  post '/posts/reply_create' => 'posts#reply_create'
  
  
  get '/posts/reply_update_view/:post_id/:reply_id' => 'posts#reply_update_view'
  post '/posts/reply_update/:post_id/:reply_id' => 'posts#reply_update'
  
  
  get '/posts/reply_destroy/:post_id/:reply_id' => 'posts#reply_destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
