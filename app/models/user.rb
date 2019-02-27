class User < ApplicationRecord
    validates :name, :email, presence: true
    validates :name, length: { maximum: 30 }
    validates :email, length: { maximum: 60 },uniqueness: true,
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

end
