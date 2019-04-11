class Spree::OfflineStore < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :coordinates, presence: true, format: /\A(-?\d+\.?\d*),\s*(-?\d+\.?\d*)\z/

  def coordinates_arr
    coordinates.split ','
  end

  def title
    "#{name}<br> #{address}"
  end
end

# == Schema Information
#
# Table name: spree_offline_stores
#
#  address     :string
#  coordinates :string
#  created_at  :datetime         not null
#  id          :bigint(8)        not null, primary key
#  name        :string
#  pin_color   :string
#  position    :integer
#  updated_at  :datetime         not null
#
