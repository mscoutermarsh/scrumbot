class AddEncryptedSecretToIntegrations < ActiveRecord::Migration
  def change
    add_column :integrations, :encrypted_secret, :string
  end
end
