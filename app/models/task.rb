class Task < ApplicationRecord
	# enum priority: [:" " , :低, :中, :高]
	# enum priority: [:低, :中, :高]
	enum priority: {" "=> 0, "低"=> 1, "中"=> 2, "高"=> 3}
	belongs_to :user
	has_many :task_labels, dependent: :destroy
	has_many :labels, through: :task_labels, source: :label

	# def save_labels(tags)
	#     current_tags = self.labels.pluck(:name) unless self.labels.nil?
	# end

	validates :title, :content, presence: true
	validates :title, uniqueness: true,length: { minimum: 1, maximum: 30 }
	validates :content,length: { minimum: 1, maximum: 600 }

	scope :sort_deadline, -> {order(deadline: :desc)}
	scope :sort_priority, -> {order(priority: :desc)}
	scope :sort_created_at, -> {order(created_at: :desc)}
	# scope :search_title_status, -> (a,b){where("title LIKE ? and status LIKE ?" , "%#{ a }%", "%#{ b }%")}
	scope :search_title, -> (a){where("title LIKE ?", "%#{ a }%")}
	scope :search_status, -> (a){where("status LIKE ?", "%#{ a }%")}
	scope :search_label, -> (a){where(id: label_ids = TaskLabel.where(label_id: a).select(:task_id))}

	before_save :skip_null_false

	private

	def skip_null_false

			if self.priority == nil
					self.priority = 0
			end
	end
end
