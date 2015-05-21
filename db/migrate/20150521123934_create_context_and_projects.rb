class CreateContextAndProjects < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.string :name,              null: false, default: ""
    end
    add_reference :contexts, :task, index: true

    create_table :projects do |t|
      t.string :name,              null: false, default: ""
    end
    add_reference :projects, :task, index: true
  end
end
