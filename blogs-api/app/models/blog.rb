class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments

  # validations
  validates_presence_of :title, :content
end
