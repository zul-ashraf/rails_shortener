Rails.application.routes.draw do
  

  resources :clicks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Static page
  # get "/404", :to => redirect("422.html")
  # get "/422", :to => redirect("422.html")
  # get "/500", :to => redirect("500.html")


  get "/analytics" => 'analytics#index'
  get "/analytics/:lookup_code" => 'analytics#show'

  post "/links" => 'links#create'
  get "/:lookup_code" => 'links#show'

  root to: "home#index"
end
