ActionController::Routing::Routes.draw do |map|
  map.resources :tags
  map.resources :taggings
  map.resources :authors
  map.resources :reviews

  map.resources :packages do |p|
    p.resources :versions 
  end

  map.root :controller => "about", :action => "index"

  map.resources :users
  map.resource  :session
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.thanks '/thanks', :controller => 'users', :action => 'signup'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.search '/packages/_search/:id', :controller => 'packages', :action => 'search'
  map.search '/packages/page/:id', :controller => 'packages', :action => 'index'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
