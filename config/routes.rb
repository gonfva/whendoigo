Whendoigo3::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  resources :trips do
    resources :reservations do
      resources :flights
    end
  end

  # You can have the root of your site routed with "root"
  root 'home#index'
  get "/home"  => "home#index"
  get "/about" => "home#about"
  get "/terms" => "home#terms"
  get "/thank_you" => "home#thanks"

  #We should fix the routes
  match "/trips_from_email/*mandrill_key" =>"trips_from_email#new_message", via: [:get, :post]
  get "/import_email"=>"trips_from_email#import"
  get "/delete_email"=>"trips_from_email#delete"

  get "/calendar/*user_email/*user_token(.:format)" => "calendar#ics"

  get "/export_tripit"=>"export_tripit#index"
  get "/tripit_authorize"=>"export_tripit#authorized"

end
