Rails.application.routes.draw do


  resources :doctors, only: [:show, :destroy]
  resources :patients, only: [:index]
  resources :hospitals, only: [:show]
  



end
