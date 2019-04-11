class Spree::CompanyBlockSection < ApplicationRecord
  belongs_to :company_block, class_name: 'Spree::CompanyBlock', touch: true, inverse_of: :sections
  acts_as_list scope: :company_block

  default_scope { order(:position) }
end

# == Schema Information
#
# Table name: spree_company_block_sections
#
#  company_block_id :bigint(8)
#  created_at       :datetime         not null
#  id               :bigint(8)        not null, primary key
#  link             :string
#  name             :string
#  position         :integer
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_spree_company_block_sections_on_company_block_id  (company_block_id)
#
