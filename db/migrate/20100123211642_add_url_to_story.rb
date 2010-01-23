class AddUrlToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :url, :string
  end

  def self.down
    remove_column :stories, :url
  end
end
