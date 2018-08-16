class BooksController < ApplicationController


    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      @book.save
      redirect_to "/books/#{@book.id}"
    end

    def show
      @book = Book.find(params[:id])
    end

    private

    def review_params
      params.require(:review).permit(:content, :rating, :book_title, :user_id)
    end

end
