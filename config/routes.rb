Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/punks/listings'
      get '/punks/:punk_identifier', to: 'punks#show', as: :punk
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
