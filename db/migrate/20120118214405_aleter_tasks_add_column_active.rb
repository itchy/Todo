class AleterTasksAddColumnActive < ActiveRecord::Migration
  def up
    add_column :tasks, :active, :integer, :default => 1
  end

  def down
    remove_column :tasks, :active
  end
end
