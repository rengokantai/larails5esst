Rails.application.routes.draw do
  #get 'subjects/index'

  #get 'subjects/show'

  #get 'subjects/edit'

  #get 'subjects/delete'
  resources :subjects do
  	member do
  		get :delete
	end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
