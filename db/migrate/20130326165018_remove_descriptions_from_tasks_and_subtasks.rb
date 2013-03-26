class RemoveDescriptionsFromTasksAndSubtasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :description
    remove_column :subtasks, :description
  end

  def down
    add_column :tasks, :description
    add_column :subtasks, :description
  end
end
