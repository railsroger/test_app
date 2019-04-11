class Spree::HeroSlide < ApplicationRecord
  MAX_COUNT = 7

  enum title_vertical_align: %w[center bottom], _prefix: 'vertical'
  enum title_horizontal_align: %w[left center right], _prefix: 'horizontal'

  has_attached_file :image,
                    styles: { admin: '100x100>', normal: '1600x900>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/hero_slides/:id/images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/hero_slides/:id/images/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :video,
                    styles: {
                      mp4: { format: 'mp4' },
                      webm: { format: 'webm' },
                      ogv: { format: 'ogv' },
                      # admin: { geometry: '100x57>>', format: 'jpg' },
                      # normal: { geometry: '1600x900>', format: 'jpg' }
                    },
                    url: '/spree/hero_slides/:id/videos/:style/:basename.:extension',
                    path: ':rails_root/public/spree/hero_slides/:id/videos/:style/:basename.:extension',
                    # default_style: :normal,
                    processors: [:transcoder]


  validates_attachment :image,
                       presence: true,
                       content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/

  process_in_background :video, queue: 'paperclip'

  acts_as_list

  attr_accessor :delete_video

  before_validation { video.clear if delete_video == '1' }

  validates :title, presence: true

  default_scope { order(:position) }
end

# == Schema Information
#
# Table name: spree_hero_slides
#
#  created_at             :datetime         not null
#  id                     :bigint(8)        not null, primary key
#  image_content_type     :string
#  image_file_name        :string
#  image_file_size        :integer
#  image_updated_at       :datetime
#  link                   :string
#  position               :integer
#  title                  :string
#  title_horizontal_align :integer
#  title_vertical_align   :integer
#  updated_at             :datetime         not null
#  video_content_type     :string
#  video_file_name        :string
#  video_file_size        :integer
#  video_processing       :boolean
#  video_updated_at       :datetime
#
