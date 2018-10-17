class BookSerializer < ActiveModel::Serializer
  attributes :id, :title 
  belongs_to :author
  has_many :reviews
end
