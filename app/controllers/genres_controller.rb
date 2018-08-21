class GenresController < ApplicationController

    before_action :require_login

  def index
    @genres = Genre.all
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to "/genres/#{@genre.id}"
    else
      render "/genres/new"
    end
  end

  def show
    @genre = Genre.find(params[:id])
    @books = @genre.books
  end

  def edit
    genre = Genre.find(params[:id])
    if genre.genre_edit?
      @genre = genre
    else
      flash[:notice] = "You may not edit this genre."
      redirect_to genre_path(genre)
    end
  end

  def update
    genre = Genre.find(params[:id])
    if genre.genre_edit?
      @genre = genre
      @genre.update(genre_params)
      @genre.save
      redirect_to genre_path(@genre)
    else
      flash[:notice] = "You may not edit this genre."
      redirect_to genre_path(genre)
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
