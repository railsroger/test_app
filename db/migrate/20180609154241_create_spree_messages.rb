class CreateSpreeMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_messages do |t|
      t.string :subject
      t.text :full_message

      t.timestamps
    end
  end
end
