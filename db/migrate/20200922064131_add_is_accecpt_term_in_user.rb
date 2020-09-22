class AddIsAccecptTermInUser < ActiveRecord::Migration[6.0]
  
  def up
    add_column :users, :accept_term, :json
  end

  def down
    remove_column :users, :accept_term
  end
end
