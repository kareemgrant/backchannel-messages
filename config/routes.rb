BackchannelMessages::Application.routes.draw do

  namespace :api do
    resources :messages, only: [:index, :create]
    get '/messages/:track_id', to: "messages#show", as: "track_messages"
  end
end
