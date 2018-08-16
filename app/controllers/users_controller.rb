class UsersController < ApplicationController
  before_action :require_login, only: [:index, :show]


  def home
  end

  def index
    @users = User.all
  end

  def new
    if !session[:user_id]
      @user = User.new
    else
      @user = User.find(session[:user_id])
      redirect_to "/users/#{@user.id}"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
    else
      redirect_to '/'
    end
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end



end
