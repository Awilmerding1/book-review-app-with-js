class UsersController < ApplicationController
  before_action :require_login, only: [:index, :show]


  def home
  end

  def index
    @users = User.all
    respond_to do |format|
        format.html { render :index}
        format.json { render json: @users, status: 200}
    end
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
      render '/users/new'
    end
  end

  def most_reviews
    @users = User.most_reviews
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    respond_to do |format|
	        format.html { render :show }
	        format.json { render json: @reviews, include: :book, status: 200}
	   end
  end


  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end


end
