Rails.application.routes.draw do
  resources :students do
    resources :items
  end
end