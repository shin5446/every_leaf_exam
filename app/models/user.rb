class User < ApplicationRecord
    has_many :tasks, dependent: :destroy
    validates :name, :email, presence: true
    validates :name, length: { maximum: 30 }
    validates :email, length: { maximum: 60 },uniqueness: true,
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    before_update  :no_edit_last_one
    before_destroy :at_least_one_admin

    private

    def at_least_one_admin

        if User.where(admin:true).size == 1
           # errors[:base] << '少なくとも1つ、ログイン用の認証が必要です'
          throw :abort
        end
    end

    def no_edit_last_one
        if User.where(admin:true).size == 1
          throw :abort unless admin == true
        end
    end
end
