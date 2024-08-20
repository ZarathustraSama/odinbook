class Text < ApplicationRecord
  has_many :posts, as: :postable
end
