class Task < ApplicationRecord
  # belongs_to :user
  validates :title, :content, presence: true
  validates :title, uniqueness: true,length: { minimum: 1, maximum: 30 }
  validates :content,length: { minimum: 1, maximum: 600 }

scope :sort_deadline, -> {order(deadline: :desc)}
scope :sort_created_at, -> {order(created_at: :desc)}
# scope :search_title_status, -> (a,b){where("title LIKE ? and status LIKE ?" , "%#{ a }%", "%#{ b }%")}
scope :search_title, -> (a){where("title LIKE ?", "%#{ a }%")}
scope :search_status, -> (a){where("status LIKE ?", "%#{ a }%")}
end
