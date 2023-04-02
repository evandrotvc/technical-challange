Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :documents do
        collection do
          get :list
          post :create
        end

        put :create
        get :generate_link
      end
    end
  end
end
