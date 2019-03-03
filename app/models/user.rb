class User < ApplicationRecord
    enum role: { admin: 1, member: 2 }
    has_many :tasks, dependent: :destroy
    validates :name, :email, presence: true
    validates :name, length: { maximum: 30 }
    validates :email, length: { maximum: 60 },uniqueness: true,
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end
