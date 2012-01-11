class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.integer :assigned
      t.string :status
      t.text :description
      t.datetime :finished_at

      t.timestamps
    end
  end
end
