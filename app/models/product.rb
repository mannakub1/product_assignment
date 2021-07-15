class Product < ApplicationRecord
  validates_presence_of :no
  validates_presence_of :imageUrl
  validates_presence_of :itemName
  validates_presence_of :price
 
  validates_uniqueness_of :no
end
