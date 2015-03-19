require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'

require_relative 'config/application'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end
############################
#######  MY ROUTES  ########
############################

get '/' do
  redirect '/meetups'
end

get '/meetups' do
  meetups = Meetup.all.order(:name)
  erb :index, locals: {meetups: meetups}
end

get '/meetups/new' do
  if signed_in?
    meetup = Meetup.new
  erb :new, locals: { meetup: meetup }
  else redirect '/example_protected_page'
  end
end

get '/meetups/:id' do
  user = current_user
  meetup = Meetup.find(params[:id])
  member = Membership.new(params[:meetup])
  erb :show, locals: { member: member, meetup: meetup, user: user }
end

post '/meetups/new' do
  meetup = Meetup.new(params[:meetup])
  if meetup.save
    flash[:notice] = "You have added an event"
    redirect "/meetups/#{meetup.id}"
  else
    erb :new, locals: {meetup: meetup}
    flash[:notice] = "Event not added"
    redirect "/"
  end
end

post '/meetups/:id' do
  user = current_user
  meetup = Meetup.find(params[:id])
  member = Membership.new(meetup_id: meetup.id, user_id: user.id)
  erb :show, locals: { meetup: meetup, member: member, user: user }
  if member.save
    flash[:notice] = "You have joined an event"
    redirect "/meetups/#{meetup.id}"
  else
    flash[:notice] = "You are already a member"
    redirect "/"
  end
end
