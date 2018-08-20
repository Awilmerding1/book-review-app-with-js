class Genre < ActiveRecord::Base
  has_many :book_genres
	has_many :books, through: :book_genres
	has_many :authors, through: :books
  validates :name, presence: true, :uniqueness => {message: "- the genre you entered has already been added to the website."}
  validate :is_title_case
  before_validation :make_title_case


  def is_title_case
    if name.split.any?{|w|w[0].upcase != w[0]}
        errors.add(:name, "Name must be in title case")
    end
  end

  def make_title_case
    self.name = self.name.titlecase
  end

end
