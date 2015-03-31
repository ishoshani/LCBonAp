class Item < ActiveRecord::Base
  belongs_to :meal
  has_many :comments, dependent: :destroy
end