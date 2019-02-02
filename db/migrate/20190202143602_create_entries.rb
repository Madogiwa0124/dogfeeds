class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.references :feed
      t.string :title
      t.string :link
      t.text :description
      t.datetime :published_at
      t.timestamps
    end
  end
end
