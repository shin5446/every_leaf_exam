class ChangeColumnLimitToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :limit, :date, using: '"limit"::date '
    rename_column :tasks, :limit, :deadline
  end
end
