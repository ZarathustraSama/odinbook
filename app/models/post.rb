class Post < ApplicationRecord
  belongs_to :user

  has_many :likes
  has_many :comments

  validates_presence_of(:body)
end
