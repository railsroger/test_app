class Spree::RightMenuItem < ApplicationRecord
  acts_as_list

  validates :name, presence: true

  scope :active, -> { where(is_active: true) }
  default_scope { order(:position) }
end

# == Schema Information
#
# Table name: spree_right_menu_items
#
#  created_at :datetime         not null
#  id         :bigint(8)        not null, primary key
#  is_active  :boolean          default(TRUE), not null
#  name       :string
#  position   :integer
#  store_id   :bigint(8)
#  updated_at :datetime         not null
#  url        :string
#
# Indexes
#
#  index_spree_right_menu_items_on_store_id  (store_id)
#
