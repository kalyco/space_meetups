configure :development do
  require 'dotenv'
  Dotenv.load

  require 'sinatra/reloader'
  require 'pry'

  also_reload 'app/**/*.rb'
end

configure do
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET']

  set :views, 'app/views'

  use OmniAuth::Builder do
    provider :github, ENV['b757c0c041e3b0ec8166'], ENV['058fc35ffb5e2701b2f7f26490cfa13106e198e5'],
      scope: 'user:email'
  end
end
