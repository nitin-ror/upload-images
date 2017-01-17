Rails.application.routes.draw do

  resources :articles, :upload_images#, :products
  root 'products#new'
  resources :products do
  	collection do
  		post 'temp_image_update' => 'products#temp_image_update', as: 'temp_image_update'
  	end
  end
end
