class Spree::ContentBlock < ApplicationRecord
  acts_as_list scope: :product

  enum kind: { HTML: 0, Image: 1, Text_Block: 2, Overview: 3, Slider_Images: 4,
               Four_Images: 5 },
       _prefix: :type

  has_attached_file :bg_image,
                    styles: { admin: '100x100>', normal: '1920x1080>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/content_blocks/:id/bg_images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/content_blocks/:id/bg_images/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :image,
                    styles: { admin: '100x100>', normal: '1920x1080>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/content_blocks/:id/images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/content_blocks/:id/images/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :image2,
                    styles: { admin: '100x100>', normal: '1920x1080>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/content_blocks/:id/image2s/:style/:basename.:extension',
                    path: ':rails_root/public/spree/content_blocks/:id/image2s/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :image3,
                    styles: { admin: '100x100>', normal: '1920x1080>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/content_blocks/:id/image3s/:style/:basename.:extension',
                    path: ':rails_root/public/spree/content_blocks/:id/image3s/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :image4,
                    styles: { admin: '100x100>', normal: '1920x1080>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/content_blocks/:id/image4s/:style/:basename.:extension',
                    path: ':rails_root/public/spree/content_blocks/:id/image4s/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :logo,
                    styles: { admin: '100x100>', normal: '1920x1080>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/content_blocks/:id/logos/:style/:basename.:extension',
                    path: ':rails_root/public/spree/content_blocks/:id/logos/:style/:basename.:extension',
                    default_style: :normal

  validates_attachment :bg_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :image2, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :image3, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :image4, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :logo, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }

  belongs_to :product, class_name: 'Spree::Product', touch: true, inverse_of: :content_blocks

  validates :name, presence: true

  default_scope { order(:position) }
  scope :active, -> { where(is_active: true) }

  def self.kinds_for_list
    kinds.map { |e| [e.first.to_s.sub('_', ' '), e.first] }
  end
end

# == Schema Information
#
# Table name: spree_content_blocks
#
#  bg_color              :string
#  bg_image_content_type :string
#  bg_image_file_name    :string
#  bg_image_file_size    :integer
#  bg_image_updated_at   :datetime
#  built_in_block        :string
#  color                 :string
#  created_at            :datetime         not null
#  hero_ui_black         :boolean
#  html                  :text
#  html2                 :text
#  id                    :bigint(8)        not null, primary key
#  image2_content_type   :string
#  image2_file_name      :string
#  image2_file_size      :integer
#  image2_updated_at     :datetime
#  image3_content_type   :string
#  image3_file_name      :string
#  image3_file_size      :integer
#  image3_updated_at     :datetime
#  image4_content_type   :string
#  image4_file_name      :string
#  image4_file_size      :integer
#  image4_updated_at     :datetime
#  image_content_type    :string
#  image_file_name       :string
#  image_file_size       :integer
#  image_updated_at      :datetime
#  is_active             :boolean          default(TRUE), not null
#  kind                  :integer          default("HTML"), not null
#  logo_content_type     :string
#  logo_file_name        :string
#  logo_file_size        :integer
#  logo_updated_at       :datetime
#  name                  :string
#  position              :integer          default(0)
#  product_id            :bigint(8)
#  string_content_type   :string
#  string_file_name      :string
#  string_file_size      :integer
#  string_updated_at     :datetime
#  text                  :text
#  text2                 :text
#  text3                 :text
#  text4                 :text
#  title                 :string
#  title2                :string
#  title3                :string
#  title4                :string
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_spree_content_blocks_on_product_id  (product_id)
#
