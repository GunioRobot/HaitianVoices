class RemoveNullConstraintOnTwitterInUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :twitter, :string, :null => true
  end

  def self.down
  end
end
