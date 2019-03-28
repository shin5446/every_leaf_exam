class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :labels
  has_secure_password

  validates :name, :email, presence: true
  validates :name, length: { maximum: 30 }
  validates :email, length: { maximum: 60 },uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  before_validation { email.downcase! }
  before_update  :no_edit_last_one
  before_destroy :at_least_one_admin

  private

  def at_least_one_admin
    if User.where(admin:true).size == 1
      throw :abort
    end
  end

  def no_edit_last_one
    if User.where(admin:true).size == 1
      throw :abort unless admin == true
    end
  end
end