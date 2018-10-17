class ReviewsController < ApplicationController

  before_action :require_login

  def new
    if params[:book_id] && !Book.exists?(params[:book_id])
      flash[:message] = "Book not found."
	     redirect_to books_path
	  else
      @review = Review.new(book_id: params[:book_id], user_id: current_user.id)
      @book = Book.find(params[:book_id])
    end
  end

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to "/books/#{@review.book_id}/reviews/#{@review.id}"
  end

    def show
      if params[:book_id]
        book = Book.find_by(id: params[:book_id])
        if book.nil?
          flash[:notice] = "Book not found."
          redirect_to books_path
        else
          @review = book.reviews.find_by(id: params[:id])
          if @review.nil?
            flash[:notice] = "Review not found."
            redirect_to book_path(book)
          else
            respond_to do |format|
            format.html { render :show }
  	        format.json { render json: @review, status: 200}
          end
          end
        end
      end
    end

    def edit
      if params[:book_id]
        book = Book.find(params[:book_id])
        if book.nil?
          flash[:notice] = "Book not found."
          redirect_to books_path
        else
          @review = book.reviews.find_by(id: params[:id])
          if @review.nil?
            flash[:notice] = "Review not found."
            redirect_to book_reviews_path(book)
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

    def destroy
      review = Review.find(params[:id])
      if current_user.id == review.user_id
        review.destroy
	       redirect_to user_path(current_user)
      else
        flash[:notice] = "You may not delete another user's review."
        redirect_to "/books/#{params[:book_id]}/reviews/#{params[:id]}"
      end
    end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :book_title, :user_id, :book_id)
  end

end
