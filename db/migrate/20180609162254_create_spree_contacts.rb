class CreateSpreeContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_contacts do |t|
      t.integer :position
      t.string :title
      t.string :phone
      t.string :working_hours_mon_sat
      t.string :working_hours_sun
      t.text :text
      t.string :faq_text
      t.string :faq_link

      t.timestamps
    end
  end
end
