class Meal < ActiveRecord::Base
  has_many :items, dependent: :destroy
  belongs_to :day
end