Rails.application.routes.draw do
  root to: 'top#index'

  resources :incomes
  resources :fixedcosts
end
