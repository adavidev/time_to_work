class AddColumnsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :asap, :boolean
    add_column :tasks, :project, :string
  end
end
