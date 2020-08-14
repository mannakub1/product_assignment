class AddColumnInUser < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :email, :string, null: false
    add_column :users, :token, :string
    add_column :users, :token_type, :string
  end

  def down
    remove_column :users, :email
    remove_column :users, :token
    remove_column :users, :token_type
  end
end
