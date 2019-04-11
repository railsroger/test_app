class Spree::CompanyPage < ApplicationRecord
  acts_as_list
  enum page_type: %i[cover_section text_section header_image main_text_image]

  has_attached_file :image,
                    styles: { admin: '100x100>', normal: '1920x1080>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/company_pages/:id/images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/company_pages/:id/images/:style/:basename.:extension',
                    default_style: :normal

  validates_attachment :image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  include DeletableAttachment

  validates :title, presence: true
  validates :page_type, presence: true

  default_scope { order(:position) }
  scope :active, -> { where(is_active: true) }
end

# == Schema Information
#
# Table name: spree_company_pages
#
#  created_at         :datetime         not null
#  header             :text
#  id                 :bigint(8)        not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  page_type          :integer          default("cover_section"), not null
#  position           :integer
#  text               :text
#  title              :string
#  updated_at         :datetime         not null
#
