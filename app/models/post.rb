class Post < ApplicationRecord
  validates :body,  :presence => true
  validates :author_name, :presence => true
end
