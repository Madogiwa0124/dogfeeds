class CreateFeedTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :feed_taggings do |t|
      t.references :feed
      t.references :feed_tag
      t.timestamps
    end
  end
end
