class SessionsController < ApplicationController

  def new
  end

  def create
    if User.find_or_create_by(name: auth[:info]['name'])
      @user = User.find_or_create_by(name: auth[:info]['name'])
    	session[:user_id] = @user.id
    	redirect_to user_path(@user)
    elsif User.find_by(name: params[:user][:name])
      @user = User.find_by(name: params[:user][:name])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
      redirect_to user_path(@user)
      end
    else
      redirect_to '/users/new'
    end
  end

	def destroy
    session.delete :name
  end

  private

	def auth
	   request.env['omniauth.auth']
	end

end
