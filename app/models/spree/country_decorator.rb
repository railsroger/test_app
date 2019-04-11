Spree::Country.class_eval do
  acts_as_list scope: 'display = #{display}'

  has_attached_file :flag,
                    styles: { admin: '100x100>', normal: '24x12#' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/countries/:id/flags/:style/:basename.:extension',
                    path: ':rails_root/public/spree/countries/:id/flags/:style/:basename.:extension',
                    default_style: :normal

  validates_attachment :flag, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  include DeletableAttachment

  default_scope { order(:position) }
  scope :active, -> { where display: true }
  scope :inactive, -> { where display: false }
end
