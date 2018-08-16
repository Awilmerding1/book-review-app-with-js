class ReviewsController < ApplicationController

  def new
    @review = Review.new(user_id: params[:user_id])
  end

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to "/users/#{current_user.id}"
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :book_title, :user_id)
  end

end
