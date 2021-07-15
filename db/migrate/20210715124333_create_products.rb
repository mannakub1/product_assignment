class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string  :no
      t.string  :imageUrl
      t.string  :itemName
      t.float   :price
      t.float   :discountPrice
      t.string  :displayHertzType, null: true
      
      t.timestamps
    end
  end
end
