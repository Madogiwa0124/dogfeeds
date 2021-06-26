class AddSuspendToFeed < ActiveRecord::Migration[6.1]
  def change
    add_column :feeds, :suspend, :boolean, null: false, default: false
  end
end
