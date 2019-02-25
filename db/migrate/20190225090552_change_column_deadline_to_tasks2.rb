class ChangeColumnDeadlineToTasks2 < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :deadline, :date, default: Time.now, null: false
  end
end
