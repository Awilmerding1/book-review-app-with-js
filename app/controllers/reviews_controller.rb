class ReviewsController < ApplicationController

  before_action :require_login

  def new
    @review = Review.new(book_id: params[:book_id], user_id: current_user.id)
    @book = Book.find(params[:book_id])
  end

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to "/books/#{@review.book_id}/reviews/#{@review.id}"
  end

    def show
      @review = Review.find(params[:id])
    end

    def edit
      if params[:book_id]
        book = Book.find(params[:book_id])
        if book.nil?
          flash[:message] = "Book not found."
          redirect_to books_path
        else
          @review = book.reviews.find_by(id: params[:id])
          if @review.nil?
            redirect_to book_reviews_path(book), flash[:message] = "Review not found."
          elsif @review.user_id == current_user.id
            @book = @review.book
          else
            flash[:notice] = "You may not edit another user's review."
            redirect_to "/books/#{params[:book_id]}/reviews/#{params[:id]}"
          end
        end
      end
    end

		def update
		  @review = Review.find(params[:id])
      if @review.user_id == current_user.id
		      @review.update(review_params)
          @review.save
		      redirect_to "/books/#{@review.book_id}/reviews/#{@review.id}"
      else
        flash[:notice] = "You may not edit another user's review."
        redirect_to "/books/#{params[:book_id]}/reviews/#{params[:id]}"
      end
		end



  private

  def review_params
    params.require(:review).permit(:content, :rating, :book_title, :user_id, :book_id)
  end

end
