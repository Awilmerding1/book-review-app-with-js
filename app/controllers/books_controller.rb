class BooksController < ApplicationController

    before_action :require_login

    def index
      @books = Book.all
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @books, include: :users, status: 200}
      end
    end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to book_path(@book)
      else
        render '/books/new'
      end
    end

    def show
      @book = Book.find(params[:id])
      @reviews = @book.reviews
      @genres = @book.genres
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @book, status: 200}
      end
    end

    def edit
      book = Book.find(params[:id])
      if book.book_edit?
        @book = book
      else
        flash[:notice] = "You may not edit this book."
        redirect_to book_path(book)
      end
    end

    def update
      book = Book.find(params[:id])
      if book.book_edit?
        @book = book
        @book.update(book_params)
        @book.save
        redirect_to book_path(@book)
      else
        @book = book
        @book.update(genre_ids: params[:book][:genre_ids], genres_attributes: params[:book][:genres_attributes])
        @book.save
        redirect_to book_path(@book)
      end
    end

    private

    def book_params
      params.require(:book).permit(:title, :author_name, genre_ids:[],
	        genres_attributes: [:name])
    end

end
