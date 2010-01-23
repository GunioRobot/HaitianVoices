class AddStoryToTranslation < ActiveRecord::Migration
  def self.up
    add_column :translations, :story_id, :integer
  end

  def self.down
    remove_column :translations, :story_id
  end
end
