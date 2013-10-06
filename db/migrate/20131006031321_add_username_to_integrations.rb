class AddUsernameToIntegrations < ActiveRecord::Migration
  def change
    add_column :integrations, :username, :string
  end
end
