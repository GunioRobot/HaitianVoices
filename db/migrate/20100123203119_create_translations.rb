class CreateTranslations < ActiveRecord::Migration
    def self.up
      create_table :translations do |t|
        t.integer   :language_id
        t.integer   :user_id
        t.string    :title
        t.text      :body
        t.boolean   :approved, :default => false
        t.integer   :approved_by
        t.timestamp :approved_on
        t.timestamps
      end
    end

    def self.down
      drop_table :translations
    end
  end
