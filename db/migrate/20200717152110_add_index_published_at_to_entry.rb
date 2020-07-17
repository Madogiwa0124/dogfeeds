class AddIndexPublishedAtToEntry < ActiveRecord::Migration[6.0]
  def change
    add_index :entries, :published_at, order: { published_at: :desc }
  end
end
