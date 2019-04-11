class CreateSpreeProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_properties do |t|
      t.string :name
      t.string :presentation, null: false
      t.string :group
      t.boolean :is_number, default: false, null: false
      

      t.timestamps null: false
    end
    add_index :spree_properties, :name
  end
end