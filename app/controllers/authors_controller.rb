class AuthorsController < ApplicationController

  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    @author.save
    redirect_to "/authors/#{@author.id}"
  end

  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end

  private

  def author_params
    params.require(:author).permit(:name, books_attributes: [:title], book_ids:[])
  end


end
