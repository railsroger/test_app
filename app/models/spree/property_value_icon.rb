class Spree::PropertyValueIcon < ApplicationRecord
  acts_as_list

  has_attached_file :icon_white,
                    styles: { admin: '100x100>', normal: '40x80>', retina: '80x160>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/property_value_icons/:id/icon_whites/:style/:basename.:extension',
                    path: ':rails_root/public/spree/property_value_icons/:id/icon_whites/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :icon_dark,
                    styles: { admin: '100x100>', normal: '40x80>', retina: '80x160>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/property_value_icons/:id/icon_dark/:style/:basename.:extension',
                    path: ':rails_root/public/spree/property_value_icons/:id/icon_dark/:style/:basename.:extension',
                    default_style: :normal


  validates_attachment :icon_white,
                       presence: true,
                       content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :icon_dark,
                       presence: true,
                       content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }

  belongs_to :property, required: true, class_name: 'Spree::Property'

  validates :value, presence: true

  default_scope { order(:position) }
end

# == Schema Information
#
# Table name: spree_property_value_icons
#
#  created_at              :datetime         not null
#  icon_dark_content_type  :string
#  icon_dark_file_name     :string
#  icon_dark_file_size     :integer
#  icon_dark_updated_at    :datetime
#  icon_white_content_type :string
#  icon_white_file_name    :string
#  icon_white_file_size    :integer
#  icon_white_updated_at   :datetime
#  id                      :bigint(8)        not null, primary key
#  position                :integer          default(0)
#  property_id             :bigint(8)
#  updated_at              :datetime         not null
#  value                   :string
#
# Indexes
#
#  index_spree_property_value_icons_on_property_id  (property_id)
#
