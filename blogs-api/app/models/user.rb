class User < ApplicationRecord
  has_many :blogs
  has_many :comments
  has_many :blogs, through: :comments

  has_secure_password

  # validations
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email
end
