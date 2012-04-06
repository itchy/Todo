class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user_id
      t.integer :assigned
      t.string :status
      t.integer :active, :default => 1
      t.text :description
      t.datetime :finished_at

      t.timestamps
    end
  end
end
