FacebookConnect::Application.routes.draw do
  get "core/index"
  get "home/locale/:locale"   => "home#locale", :as => 'set_locale'
  post "oauth/callback"   => "oauth#callback", :as => 'oauth_callback'
  root :to => 'core#index'
end
