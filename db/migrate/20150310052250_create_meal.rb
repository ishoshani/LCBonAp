class CreateMeal < ActiveRecord::Migration
  def change
    create_table :meals do |m|
      m.string :name
    end
    change_table :items do |i|
      i.belongs_to :meal
    end
    add_index :items, :meal_id
  end
end
