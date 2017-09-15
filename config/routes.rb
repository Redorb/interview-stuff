Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    resources :user_profiles, only: [:show]

    resources :pet_owners, only: [:index, :show] do
      resources :pets
      resources :bookings, controller: 'pet_owner_bookings'
    end

    resources :sitters, only: [:index, :show] do
      resources :sittings, controller: 'sitter_sittings'
    end
  end
end
