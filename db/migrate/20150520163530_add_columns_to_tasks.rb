class AddColumnsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :asap, :boolean
  end
end
