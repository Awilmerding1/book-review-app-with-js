class User < ActiveRecord::Base
  has_many :reviews
	has_many :books, through: :reviews
	has_many :authors, through: :books
	has_many :genres, through: :books
  validates :name, presence: true, uniqueness: true
  has_secure_password

  scope :alphabetized, -> {order(:name)}

  scope :most_reviews, -> {joins(:reviews).group("users.id").order("count(reviews.id) DESC").limit(5)}


end
