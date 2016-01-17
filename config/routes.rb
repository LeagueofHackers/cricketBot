Rails.application.routes.draw do
  post 'bot' => 'response#create'
  get 'bot' => 'oauth#create'
end
