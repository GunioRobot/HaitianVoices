class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string :caption, :limit => 1000
      t.string :photo_file_name # Original filename
      t.string :photo_content_type # Mime type
      t.integer :photo_file_size # File size in bytes
      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end

end
