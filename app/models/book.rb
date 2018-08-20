class Book < ActiveRecord::Base
  belongs_to :author
	has_many :book_genres
	has_many :genres, through: :book_genres
	has_many :reviews
	has_many :users, through: :reviews
  validates :title, :presence => {message: "- please enter a title."}, :uniqueness => {message: "- the book title you entered has already been added to the website."}
  validate :is_title_case
	before_validation :make_title_case

  accepts_nested_attributes_for :genres

  def author_name=(name)
    self.author = Author.find_or_create_by(name: name)
  end

  def author_name
    self.author ? self.author.name : nil
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end

  def genres_attributes=(genre_attributes)
    genre_attributes.values.each do |genre_attribute|
      if Genre.find_by(genre_attribute)
        genre = Genre.find_by(genre_attribute)
        self.genres << genre
      else
        unless genre_attribute.values.first == ""
          genre = Genre.new(genre_attribute)
          genre.save
          self.genres << genre
        end
      end
    end
  end

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
        errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end



end
