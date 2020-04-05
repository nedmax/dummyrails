Rails.application.routes.draw do
  get 'welcome/index'

  get "/healthcheck" => "healthcheck#healthcheck", as: "healthcheck"

  resources :articles

  root 'welcome#index'
end
