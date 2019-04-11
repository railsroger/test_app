class Spree::CompanyBlock < ApplicationRecord
  has_attached_file :video_cover,
                    styles: { admin: '100x100>', normal: '1600x900>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/company_blocks/:id/video_covers/:style/:basename.:extension',
                    path: ':rails_root/public/spree/company_blocks/:id/video_covers/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :video,
                    styles: {
                      mp4: { format: 'mp4' },
                      webm: { format: 'webm' },
                      ogv: { format: 'ogv' },
                      # admin: { geometry: '100x57>>', format: 'jpg' },
                      # normal: { geometry: '1600x900>', format: 'jpg' }
                    },
                    url: '/spree/company_blocks/:id/videos/:style/:basename.:extension',
                    path: ':rails_root/public/spree/company_blocks/:id/videos/:style/:basename.:extension',
                    # default_style: :normal,
                    processors: [:transcoder]


  validates_attachment :video_cover, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/

  process_in_background :video, queue: 'paperclip'

  has_many :sections, class_name: 'Spree::CompanyBlockSection', dependent: :destroy, inverse_of: :company_block

  accepts_nested_attributes_for :sections, reject_if: ->(ov) { ov[:name].blank? || ov[:link].blank? }, allow_destroy: true
end

# == Schema Information
#
# Table name: spree_company_blocks
#
#  created_at               :datetime         not null
#  id                       :bigint(8)        not null, primary key
#  is_active                :boolean
#  main_statement           :string
#  updated_at               :datetime         not null
#  video_content_type       :string
#  video_cover_content_type :string
#  video_cover_file_name    :string
#  video_cover_file_size    :integer
#  video_cover_updated_at   :datetime
#  video_file_name          :string
#  video_file_size          :integer
#  video_processing         :boolean
#  video_statement          :string
#  video_updated_at         :datetime
#
