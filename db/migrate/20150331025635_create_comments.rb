class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |c|
      c.string :email
      c.text :comment
      c.datetime :created_at
      c.belongs_to :item
    end
    add_index :comments, :item_id
  end
end
