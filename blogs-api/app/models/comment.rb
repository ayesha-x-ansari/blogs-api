class Comment < ApplicationRecord
  belongs_to :blog
  belongs_to :user
  # validations
  validates_presence_of :content
end
