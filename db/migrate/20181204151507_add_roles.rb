class AddRoles < ActiveRecord::Migration[5.1]
  def up
    Spree::Role.find_or_create_by(name: 'super')
    Spree::Role.find_or_create_by(name: 'content_manager')
  end
  
  def down
    Spree::Role.where(name: %w[super content_manager]).destroy_all
  end
end
