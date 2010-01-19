class AddApprovedToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :approved, :boolean, :default => false
    add_column :stories, :approved_by, :integer
    add_column :stories, :approved_on, :datetime
  end

  def self.down
    remove_column :stories, :approved_on
    remove_column :stories, :approved_by
    remove_column :stories, :approved
  end
end
