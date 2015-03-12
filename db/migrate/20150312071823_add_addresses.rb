class AddAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |a|
      a.string :address
      a.belongs_to :item
    end
    add_index :addresses, :item_id
  end
end
