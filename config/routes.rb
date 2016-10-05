Rails.application.routes.draw do


  #get 'public/index'

  get 'show/:permalink', :to=>'public#show'

  get 'admin_users/delete'

  root :to=>'public#index'
  get 'admin', :to =>'access#menu'
  get 'access/menu'

  get 'access/login'
  get 'access/logout'

  post 'access/attempt_login'

  #get 'subjects/index'

  #get 'subjects/show'

  #get 'subjects/edit'

  #get 'subjects/delete'

  resources :admin_users, :except => [:show] do
    member do
      get :delete
    end
  end

  resources :subjects do
  	member do
  		get :delete
	  end
  end
  resources :pages do
    member do
      get :delete
    end
  end
  resources :sections do
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
