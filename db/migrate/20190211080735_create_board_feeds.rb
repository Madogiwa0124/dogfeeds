class CreateBoardFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :board_feeds do |t|
      t.references :board
      t.references :feed
      t.timestamps
    end
  end
end
