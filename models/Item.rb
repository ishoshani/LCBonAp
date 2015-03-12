class Item < ActiveRecord::Base
  has_many :addresses, dependent: :destroy
  belongs_to :meal
end