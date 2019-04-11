class Spree::News < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_attached_file :list_image,
                    styles: { admin: '100x100>', large: '1300x1300#', small: '650x650#', normal: '1920x1080>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/news/:id/list_images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/news/:id/list_images/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :main_image,
                    styles: { admin: '100x100>', normal: '1920x9999>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/news/:id/main_images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/news/:id/main_images/:style/:basename.:extension',
                    default_style: :normal

  validates_attachment :list_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :main_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }

  belongs_to :category, class_name: 'Spree::NewsCategory', optional: true
  belongs_to :sponsorship, class_name: 'Spree::Sponsorship', optional: true

  default_scope -> { order(published_on: :desc) }
  scope :published, -> { where(is_published: true) }


  before_validation :process_attributes
  before_validation :normalize_slug, on: :update
  validates :title, presence: true
  validates :published_on, presence: true
  validates :slug, presence: true, uniqueness: { allow_blank: true }

  def name
    title
  end

  def slug_candidates
    [[:published_on, '-', :title]]
  end

  def should_generate_new_friendly_id?
    title_changed? || published_on_changed? || slug.blank? || super
  end

  def normalize_slug
    self.slug = normalize_friendly_id(slug)
  end

  def normalize_friendly_id(input)
    input.to_s.to_ascii.to_slug.normalize.to_s
  end

  private

  def process_attributes
    self.published_on = Date.today if published_on.nil? && is_published?
    process_text if text_raw_changed?
  end

  def process_text
    self.text = String.new(text_raw || '')
    text.gsub!(/<img src="([^"]+)"( alt="(.*)")?>/) do
      ApplicationController.helpers.img_html Regexp.last_match[1], Regexp.last_match[3]
    end
    text.gsub!(/<gallery urls="([^<>]+)"><\/gallery>/) do
      ApplicationController.helpers.gallery_html Regexp.last_match[1]
    end
  end
end

# == Schema Information
#
# Table name: spree_news
#
#  category_id             :bigint(8)
#  created_at              :datetime         not null
#  id                      :bigint(8)        not null, primary key
#  is_published            :boolean
#  list_image_content_type :string
#  list_image_file_name    :string
#  list_image_file_size    :integer
#  list_image_updated_at   :datetime
#  main_image_content_type :string
#  main_image_file_name    :string
#  main_image_file_size    :integer
#  main_image_updated_at   :datetime
#  published_on            :date
#  slug                    :string
#  sponsorship_id          :bigint(8)
#  text                    :text
#  text_raw                :text
#  title                   :string
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_spree_news_on_category_id     (category_id)
#  index_spree_news_on_sponsorship_id  (sponsorship_id)
#
