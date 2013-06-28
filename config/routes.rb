BackchannelMessages::Application.routes.draw do

  namespace :api do
    get '/messages', to: "messages#index", as: "all_messages"
    resources :tracks, only: [] do
      resources :messages, only: [:create] do
        collection do
          get :show
        end
      end
    end
  end
end
