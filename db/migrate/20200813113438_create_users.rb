class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :token
      t.string  :token_type
      t.string  :account_id
      t.json    :goal
      t.json    :salary
      t.json    :provident_fund
      t.json    :social_security
      t.json    :saving
      t.json    :post_retirement
      t.timestamps
    end
  end
end
