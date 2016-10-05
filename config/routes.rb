Rails.application.routes.draw do
  get 'admin_users/index'

  get 'admin_users/new'

  get 'admin_users/edit'

  get 'admin_users/delete'

  root 'demo#index'
  get 'admin', :to =>'access#menu'
  get 'access/menu'

  get 'access/login'
  get 'access/logout'

  post 'access/attempt_login'

  #get 'subjects/index'

  #get 'subjects/show'

  #get 'subjects/edit'

  #get 'subjects/delete'
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
