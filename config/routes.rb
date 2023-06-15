Rails.application.routes.draw do
  devise_for :users
  
  root to: redirect('/projects')

  resources :projects, only: [:index, :show] do
    resources :comments, only: [:create]
    member do
      put :submit
      put :approve
      put :reject
      put :cancel
    end
  end
  
end
