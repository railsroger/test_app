class StoreAddRobots < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_stores, :robots, :text
  end
end
