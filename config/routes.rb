Rails.application.routes.draw do
  mount Movies::API => '/'
end
