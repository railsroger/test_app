class Spree::TaxonsRightMenuItem < ApplicationRecord
  belongs_to :taxon, class_name: 'Spree::Taxon', touch: true, inverse_of: :right_menu_items
  acts_as_list scope: :taxon

  default_scope { order(:position) }
end

# == Schema Information
#
# Table name: spree_taxons_right_menu_items
#
#  created_at :datetime         not null
#  id         :bigint(8)        not null, primary key
#  link       :string
#  name       :string
#  position   :integer
#  taxon_id   :bigint(8)
#  updated_at :datetime         not null
#
# Indexes
#
#  index_spree_taxons_right_menu_items_on_taxon_id  (taxon_id)
#
