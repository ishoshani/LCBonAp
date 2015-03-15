class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |d|
      d.integer :day
      d.datetime :week
    end
    change_table :meals do |m|
      m.belongs_to :day
    end
    add_index :meals, :day_id
  end
end
