class UserController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if params[:first_name] == "" || params[:last_name] == "" || params[:email] == "" || params[:username] == "" || params[:password] == "" 
      redirect '/signup'
    else
      @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], username: params[:username], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      erb :'reviews/reviews'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      erb :'reviews/reviews'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      erb :'reviews/reviews'
    else
      redirect '/signup'
    end
  end

  get '/logout' do 
    session[:user_id] = nil
    redirect '/login'
  end
  
end