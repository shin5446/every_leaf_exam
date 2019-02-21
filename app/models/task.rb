class Task < ApplicationRecord
  # belongs_to :user
  validates :title, :content, presence: true
  validates :title, uniqueness: true,length: { minimum: 1, maximum: 30 }
  validates :content,length: { minimum: 1, maximum: 600 }
end
