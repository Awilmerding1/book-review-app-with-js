class ReviewsController < ApplicationController

  def new
  end

  def create
  end

  def show
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :book_id, :user_id)
  end

end
