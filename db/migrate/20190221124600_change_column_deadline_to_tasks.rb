class ChangeColumnDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :deadline, :date, using: '"deadline"::date '
  end
end
