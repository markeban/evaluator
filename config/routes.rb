Rails.application.routes.draw do
  root 'pages#index'
  get 'account', to: 'pages#account'
  get '/pricing', to: 'pages#pricing'
  get '/how_it_works', to: 'pages#how_it_works'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :evaluations
  resources :teachers
  resources :answers
  resources :subscriptions, only: [:new, :create, :show, :destroy]
  get '/respondents/unsubscribe/:signature' => 'respondents#unsubscribe', as: 'unsubscribe'
  patch '/respondents/:signature', to: 'respondents#update'
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
      get 'evaluations/:id', to: 'evaluations#show'
      patch 'evaluations/:id', to: 'evaluations#email_respondents'
      get '/evaluations/email_respondents/:id', to: 'evaluations#email_respondents'
    end
  end
 
  # get    '/submissions/new' => 'submissions#new'
  get    '/submissions' => 'submissions#index'
  post    '/submissions' =>  'submissions#create', :as => :submissions_path         
  get    '/submissions/:id/edit' => 'submissions#edit'
  get    '/submissions/:id/new' => 'submissions#new', as: :new_submissions            #unRESTful route
  patch  '/submissions/:id' => 'submissions#update'
  put    '/submissions/:id' =>  'submissions#update'
  delete '/submissions/:id' =>  'submissions#destroy'
  get 'submissions/complete' => 'submissions#complete' #unRESTful route

  get '/analysis' => 'analysis#index'
  # post '/analysis/instructor_only' => 'analysis#instructor_only'
  get '/analysis/instructor_only' => 'analysis#instructor_only'
  get '/analysis/instructor_only/:id' => 'analysis#instructor_only_show'
  get '/analysis/instructor_only/templates/:id' => 'analysis#instructor_only_show_template'
  get '/analysis/templates/:id' => 'analysis#template'


  get '/chart' => 'pages#chart'
  get '/chart' => 'analysis#index'
  get '/chart' => 'analysis#instructor_only'



end
