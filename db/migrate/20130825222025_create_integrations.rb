class CreateIntegrations < ActiveRecord::Migration
  def change
    create_table :integrations do |t|
      t.integer :user_id
      t.integer :account_id
      t.string :access_token
      t.string :access_secret

      t.timestamps
    end

    add_index :integrations, [:user_id, :account_id]
  end
end
