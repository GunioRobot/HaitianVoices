class AddAboutToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :about, :text
  end

  def self.down
    remove_column :stories, :about
  end
end
