class Author < ActiveRecord::Base
  has_many :books
	has_many :reviews, through: :books
	has_many :users, through: :books
	has_many :genres, through: :books

  accepts_nested_attributes_for :books

  def books_attributes=(book_attributes)
      book_attributes.values.each do |book_attribute|
          book = Book.find_or_create_by(book_attribute)
          self.books << book
      end
  end

end
