Rails.application.routes.draw do
  devise_for :users,
               path: '',
               path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
               },
               controllers: {
                 sessions: 'sessions',
                 registrations: 'registrations'
               }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, :defaults => {:format => :json} do
    resources :projects do
      resources :tasks do
        resources :comments, only: [:index, :create, :show, :destroy]
      end
      get 'tasks/:id/done', to: 'tasks_done#update'
      get 'tasks/:id/up', to: 'priority_up#update'
      get 'tasks/:id/down', to: 'priority_down#update'

    end
  end
end
