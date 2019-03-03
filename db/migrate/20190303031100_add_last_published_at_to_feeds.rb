class AddLastPublishedAtToFeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :last_published_at, :datetime
  end
end
