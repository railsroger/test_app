class SponsorshipsTitle < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_sponsorships, :title, :string
  end
end
