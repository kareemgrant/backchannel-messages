BackchannelMessages::Application.routes.draw do

  namespace :api do
    resources :messages, only: [:index, :show, :create]
  end
end
