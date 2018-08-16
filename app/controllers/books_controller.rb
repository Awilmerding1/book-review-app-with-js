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
      @reviews = @book.reviews
    end

    private

    def book_params
      params.require(:book).permit(:title, :author_name)
    end

end
