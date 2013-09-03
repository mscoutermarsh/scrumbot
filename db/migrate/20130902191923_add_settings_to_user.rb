class AddSettingsToUser < ActiveRecord::Migration
  def up
    add_column :users, :settings, :hstore
  end

  def down
    remove_column :users, :settings
  end
end
