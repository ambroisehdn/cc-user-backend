Rails.application.routes.draw do
  get '/wallet', to: 'wallet#get_wallet'
  post '/wallet', to: 'wallet#create_wallet'
end