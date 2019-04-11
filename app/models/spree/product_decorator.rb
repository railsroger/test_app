Spree::Product.class_eval do

  has_attached_file :preview_image,
                    styles: { admin: '100x100>', normal: '600x600>', big: '1000x1000>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/products/:id/preview_images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/products/:id/preview_images/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :hero_image,
                    styles: { admin: '100x100>', normal: '800x800>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/products/:id/hero_images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/products/:id/hero_images/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :hero_bg_image,
                    styles: { admin: '100x100>', normal: '1920x1080>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/products/:id/hero_bg_images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/products/:id/hero_bg_images/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :video_cover,
                    styles: { admin: '100x100>', normal: '1600x900>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/products/:id/video_covers/:style/:basename.:extension',
                    path: ':rails_root/public/spree/products/:id/video_covers/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :video,
                    styles: {
                      mp4: { format: 'mp4' },
                      webm: { format: 'webm' },
                      ogv: { format: 'ogv' },
                      # admin: { geometry: '100x57>', format: 'jpg' },
                      # normal: { geometry: '800x456>', format: 'jpg' }
                    },
                    url: '/spree/products/:id/videos/:style/:basename.:extension',
                    path: ':rails_root/public/spree/products/:id/videos/:style/:basename.:extension',
                    # default_style: :normal,
                    processors: [:transcoder]

  has_attached_file :icon_white1,
                    styles: { admin: '100x100>', normal: '40x80>', retina: '80x160>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/property_value_icons/:id/icon_white1s/:style/:basename.:extension',
                    path: ':rails_root/public/spree/property_value_icons/:id/icon_white1s/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :icon_dark1,
                    styles: { admin: '100x100>', normal: '40x80>', retina: '80x160>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/property_value_icons/:id/icon_dark1/:style/:basename.:extension',
                    path: ':rails_root/public/spree/property_value_icons/:id/icon_dark1/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :icon_white2,
                    styles: { admin: '100x100>', normal: '40x80>', retina: '80x160>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/property_value_icons/:id/icon_white2s/:style/:basename.:extension',
                    path: ':rails_root/public/spree/property_value_icons/:id/icon_white2s/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :icon_dark2,
                    styles: { admin: '100x100>', normal: '40x80>', retina: '80x160>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/property_value_icons/:id/icon_dark2/:style/:basename.:extension',
                    path: ':rails_root/public/spree/property_value_icons/:id/icon_dark2/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :icon_white3,
                    styles: { admin: '100x100>', normal: '40x80>', retina: '80x160>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/property_value_icons/:id/icon_white3s/:style/:basename.:extension',
                    path: ':rails_root/public/spree/property_value_icons/:id/icon_white3s/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :icon_dark3,
                    styles: { admin: '100x100>', normal: '40x80>', retina: '80x160>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/property_value_icons/:id/icon_dark3/:style/:basename.:extension',
                    path: ':rails_root/public/spree/property_value_icons/:id/icon_dark3/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :icon_white4,
                    styles: { admin: '100x100>', normal: '40x80>', retina: '80x160>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/property_value_icons/:id/icon_white4s/:style/:basename.:extension',
                    path: ':rails_root/public/spree/property_value_icons/:id/icon_white4s/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :icon_dark4,
                    styles: { admin: '100x100>', normal: '40x80>', retina: '80x160>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/property_value_icons/:id/icon_dark4/:style/:basename.:extension',
                    path: ':rails_root/public/spree/property_value_icons/:id/icon_dark4/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :icon_white5,
                    styles: { admin: '100x100>', normal: '40x80>', retina: '80x160>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/property_value_icons/:id/icon_white5s/:style/:basename.:extension',
                    path: ':rails_root/public/spree/property_value_icons/:id/icon_white5s/:style/:basename.:extension',
                    default_style: :normal
  has_attached_file :icon_dark5,
                    styles: { admin: '100x100>', normal: '40x80>', retina: '80x160>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/property_value_icons/:id/icon_dark5/:style/:basename.:extension',
                    path: ':rails_root/public/spree/property_value_icons/:id/icon_dark5/:style/:basename.:extension',
                    default_style: :normal


  validates_attachment :preview_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :hero_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :hero_bg_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :video_cover, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/
  include DeletableAttachment
  process_in_background :video, queue: 'paperclip'
  validates_attachment :icon_white1, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :icon_dark1, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :icon_white2, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :icon_dark2, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :icon_white3, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :icon_dark3, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :icon_white4, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :icon_dark4, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :icon_white5, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :icon_dark5, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }

  has_many :content_blocks, class_name: 'Spree::ContentBlock', inverse_of: :product, dependent: :destroy

  after_create :create_built_in_blocks

  scope :big_preview, -> { where big_preview: true }
  scope :small_preview, -> { where big_preview: false }

  def category_taxon
    taxons.find_by(taxonomy: Spree::Taxonomy.find_or_initialize_by(name: 'Categories'))
  end

  def series
    series_taxonomy = Spree::Taxonomy.find_by(name: 'Product Series')
    return '' unless series_taxonomy
    taxon = taxons.where(taxonomy: series_taxonomy).first
    return '' unless taxon
    taxon.name
  end

  def create_built_in_blocks
    content_blocks.create!(built_in_block: 'gallery', name: 'Gallery')
    content_blocks.create!(built_in_block: 'specs', name: 'Specs')
    content_blocks.create!(built_in_block: 'video', name: 'Video')
    content_blocks.create!(built_in_block: 'support', name: 'Support')
    content_blocks.create!(built_in_block: 'disclaimer', name: 'Disclaimer')
  end
end
