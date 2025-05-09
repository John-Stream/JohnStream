class User < ApplicationRecord
  has_many :posts
  has_many :comments
  
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def display_name
    username || full_name
  end
end
