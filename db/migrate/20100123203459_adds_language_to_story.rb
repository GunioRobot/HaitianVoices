class AddsLanguageToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :language_id, :integer
  end

  def self.down
    remove_column :stories, :language_id
  end
end
