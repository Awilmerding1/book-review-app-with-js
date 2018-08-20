class ReviewsController < ApplicationController

  def show
    @review = Review.find(params[:id])
  end
  
  def new
    @review = Review.new(book_id: params[:book_id], user_id: current_user.id)
    @book = Book.find(params[:book_id])
  end

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to "/book/#{@review.book_id}/reviews/#{@review.id}"
  end



  private

  def review_params
    params.require(:review).permit(:content, :rating, :book_title, :user_id, :book_id)
  end

end
