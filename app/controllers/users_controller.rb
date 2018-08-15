class UsersController < ApplicationController
  before_action :require_login

  def home
  end

  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end

  

end
