class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  has_many :genres, through: :book
  validates :content, presence: true
  validates :rating, inclusion: { in: 1..5}, presence: true

  def book_title=(title)
    self.book = Book.find_or_create_by(title: title)
  end

  def book_title
    self.book ? self.book.title : nil
  end


end
