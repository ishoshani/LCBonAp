class AddMealToMenuItem < ActiveRecord::Migration
  def change
    change_table :menu_items do |i|
      i.string :meal
    end
  end
end
