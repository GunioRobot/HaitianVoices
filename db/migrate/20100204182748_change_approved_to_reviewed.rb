class ChangeApprovedToReviewed < ActiveRecord::Migration
  
  def self.up
    rename_column :stories, :approved_on, :reviewed_at
    rename_column :stories, :approved_by, :reviewed_by
    rename_column :translations, :approved_on, :reviewed_at
    rename_column :translations, :approved_by, :reviewed_by
  end

  def self.down
    rename_column :stories, :reviewed_at, :approved_on
    rename_column :stories, :reviewed_by, :approved_by
    rename_column :translations, :reviewed_at, :approved_on
    rename_column :translations, :reviewed_by, :approved_by
  end
  
end
