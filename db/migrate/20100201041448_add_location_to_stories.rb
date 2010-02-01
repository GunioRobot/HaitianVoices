class AddLocationToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :location, :string
  end

  def self.down
    remove_column :stories, :location
  end
end
