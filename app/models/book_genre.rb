class BookGenre < ActiveRecord::Base
  belongs_to :book
  belongs_to :genre

  validates_uniqueness_of :genre_id, :scope => :book_id


end
