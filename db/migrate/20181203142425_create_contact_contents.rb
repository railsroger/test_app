class CreateContactContents < ActiveRecord::Migration[5.1]
  def up
    create_table :spree_contact_contents do |t|
      t.text :headoffice_address
      t.text :sales_and_roduct
      t.text :media
      t.text :retailers_benefits

      t.timestamps
    end

    Spree::ContactContent.create! unless Spree::ContactContent.any?
  end

  def down
    drop_table :spree_contact_contents
  end
end
