class EncryptedColumnNames < ActiveRecord::Migration
  def change
    rename_column :integrations, :access_token, :encrypted_token
    rename_column :integrations, :username, :encrypted_username
    remove_column :integrations, :access_secret
  end
end
