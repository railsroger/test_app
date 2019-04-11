class Spree::FooterItem < ApplicationRecord
  acts_as_list

  with_options presence: true do
    validates :name
    validates :url
  end

  default_scope { order(:position) }
end

# == Schema Information
#
# Table name: spree_footer_items
#
#  created_at :datetime         not null
#  id         :bigint(8)        not null, primary key
#  name       :string
#  position   :integer
#  updated_at :datetime         not null
#  url        :string
#
