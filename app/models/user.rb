class User < ApplicationRecord
  validates :name, presence: true, lenght: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end