class TrackersAddFields < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_trackers, :header, :text
    add_column :spree_trackers, :body_starts, :text
    rename_column :spree_trackers, :code, :body_ends
  end
end
