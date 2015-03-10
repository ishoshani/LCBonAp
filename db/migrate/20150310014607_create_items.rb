class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |i|
      i.string :station
      i.text :description
      i.integer :votes
    end
  end
end
