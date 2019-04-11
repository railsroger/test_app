class Spree::PopularSearch < ApplicationRecord
  acts_as_list

  validates :text, presence: true

  default_scope { order(:position) }
end

# == Schema Information
#
# Table name: spree_popular_searches
#
#  created_at :datetime         not null
#  id         :bigint(8)        not null, primary key
#  position   :integer
#  text       :string
#  updated_at :datetime         not null
#
