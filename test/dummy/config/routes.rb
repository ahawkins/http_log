Dummy::Application.routes.draw do
  root :to => 'echo#echo', :as => :echo
  mount HttpLogger::Engine => '/logs'
end
