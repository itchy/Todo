class AlterUsersAddColumnActive < ActiveRecord::Migration
  def up
    add_column :users, :active, :integer, :default => 1
  end

  def down
    remove_column :users, :active
  end
end
