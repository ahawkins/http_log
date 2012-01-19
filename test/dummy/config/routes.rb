Dummy::Application.routes.draw do
  root :to => 'echo#echo', :as => :echo
  mount HttpLog::Engine => '/logs'
end
