class Author < ActiveRecord::Base
  has_many :books
	has_many :reviews, through: :books
	has_many :users, through: :books
	has_many :genres, through: :books
  validates :name, presence: true, uniqueness: true
  validate :is_title_case
	before_validation :make_title_case 

  accepts_nested_attributes_for :books

  def books_attributes=(book_attributes)
      book_attributes.values.each do |book_attribute|
          book = Book.find_or_create_by(book_attribute)
          self.books << book
      end
  end

  def is_title_case
    if name.split.any?{|w|w[0].upcase != w[0]}
        errors.add(:name, "Name must be in title case")
    end
  end

  def make_title_case
    self.name = self.name.titlecase
  end


end
