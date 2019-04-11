class Spree::Sponsorship < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  acts_as_list

  has_attached_file :main_image,
                    styles: { admin: '100x100>', normal: '1920x1080>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/sponsorships/:id/main_image/:style/:basename.:extension',
                    path: ':rails_root/public/spree/sponsorships/:id/main_image/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :preview_image,
                    styles: { admin: '100x100>', normal: '1080x1080>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/sponsorships/:id/preview_image/:style/:basename.:extension',
                    path: ':rails_root/public/spree/sponsorships/:id/preview_image/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :pattern_image,
                    styles: { admin: '100x100>', normal: '1920x580>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/sponsorships/:id/pattern_image/:style/:basename.:extension',
                    path: ':rails_root/public/spree/sponsorships/:id/pattern_image/:style/:basename.:extension',
                    default_style: :normal

  validates_attachment :main_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :preview_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :pattern_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }

  has_many :news, class_name: 'Spree::News'

  default_scope { order(:position) }

  before_validation :normalize_slug, on: :update
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { allow_blank: true }

  def slug_candidates
    [:name]
  end

  def should_generate_new_friendly_id?
    name_changed? || slug.blank? || super
  end

  def normalize_slug
    self.slug = normalize_friendly_id(slug)
  end
end

# == Schema Information
#
# Table name: spree_sponsorships
#
#  created_at                 :datetime         not null
#  id                         :bigint(8)        not null, primary key
#  main_image_content_type    :string
#  main_image_file_name       :string
#  main_image_file_size       :integer
#  main_image_updated_at      :datetime
#  name                       :string
#  pattern_image_content_type :string
#  pattern_image_file_name    :string
#  pattern_image_file_size    :integer
#  pattern_image_updated_at   :datetime
#  position                   :integer
#  preview_image_content_type :string
#  preview_image_file_name    :string
#  preview_image_file_size    :integer
#  preview_image_updated_at   :datetime
#  slogan                     :string
#  slug                       :string
#  text                       :text
#  title                      :string
#  updated_at                 :datetime         not null
#
