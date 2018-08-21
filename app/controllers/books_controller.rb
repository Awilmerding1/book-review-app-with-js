class BooksController < ApplicationController

    before_action :require_login

    def index
      @books = Book.all
    end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to "/books/#{@book.id}"
      else
        render '/books/new'
      end
    end

    def show
      @book = Book.find(params[:id])
      @reviews = @book.reviews
      @genres = @book.genres
    end

    private

    def book_params
      params.require(:book).permit(:title, :author_name, genre_ids:[],
	        genres_attributes: [:name])
    end

end
