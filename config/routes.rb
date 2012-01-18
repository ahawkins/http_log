HttpLogger::Engine.routes.draw do
  resources :requests, :only => :show, :as => :http_requests
end
