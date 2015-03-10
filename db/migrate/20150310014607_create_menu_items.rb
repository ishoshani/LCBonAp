class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |i|
      i.string :station
      i.text :description
      i.integer :votes
    end
  end
end
