class AddIndexUniqueInUser < ActiveRecord::Migration[6.0]
  
  def up
    add_index :users, [:account_id, :token_type], name: "index_user_unique", unique: true
  end

  def down
    remove_index :users, name: "index_user_unique"
  end

end
