class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.references :genre
      t.text :story_text
      t.timestamps
    end
  end
end
