Rails.application.routes.draw do
  root 'pages#index'
  get '/pricing', to: 'pages#pricing'
  devise_for :users
  resources :evaluations
  resources :teachers
  resources :answers
  resources :subscriptions, only: [:new, :create]
  resources :templates do
    resources :questions
  end
  

  namespace :api do
    namespace :v1 do
      resources :questions
      post '/questions/batch' => 'questions#batch_create'
      post '/questions/batch_destroy' => 'questions#batch_destroy'
      resources :question_options
      post '/question_options/batch_destroy' => 'question_options#batch_destroy'
      resources :respondents
      post '/respondents/batch', to: 'respondents#batch'
      patch 'evaluations/:id', to: 'evaluations#update'
      get '/evaluations/email_respondents/:id', to: 'evaluations#email_respondents'
    end
  end
 
  get    '/submissions/new' => 'submissions#new'
  get    '/submissions' => 'submissions#index'
  post    '/submissions' =>  'submissions#create', :as => :submissions_path         
  get    '/submissions/:id/edit' => 'submissions#edit'
  get    '/submissions/:id/new' => 'submissions#new'            #unRESTful route
  patch  '/submissions/:id' => 'submissions#update'
  put    '/submissions/:id' =>  'submissions#update'
  delete '/submissions/:id' =>  'submissions#destroy'
  get 'submissions/complete' => 'submissions#complete' #unRESTful route

  get '/analysis' => 'analysis#index'
  post '/analysis/instructor_only' => 'analysis#instructor_only'
  get '/analysis/instructor_only' => 'analysis#instructor_only'
  get '/analysis/instructor_only/:id' => 'analysis#instructor_only_show'
  get '/analysis/instructor_only/templates/:id' => 'analysis#instructor_only_show_template'


  get '/chart' => 'pages#chart'
  get '/chart' => 'analysis#index'
  get '/chart' => 'analysis#instructor_only'


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
