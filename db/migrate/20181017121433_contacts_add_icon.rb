class ContactsAddIcon < ActiveRecord::Migration[5.1]
  def change
    add_attachment :spree_contacts, :icon
  end
end
