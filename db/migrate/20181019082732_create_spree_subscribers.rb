class CreateSpreeSubscribers < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_subscribers do |t|
      t.string :email

      t.timestamps
    end
  end
end
