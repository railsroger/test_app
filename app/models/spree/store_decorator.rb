Spree::Store.class_eval do
  has_attached_file :og_image,
                    styles: { admin: '100x100>', normal: '100x100>' },
                    url: '/spree/stores/:id/og_images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/stores/:id/og_images/:style/:basename.:extension',
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
  has_attached_file :downloads_blank_icon,
                    styles: { admin: '100x100>', normal: '100x100>' },
                    url: '/spree/stores/:id/downloads_blank_icons/:style/:basename.:extension',
                    path: ':rails_root/public/spree/stores/:id/downloads_blank_icons/:style/:basename.:extension',
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' }

  validates_attachment :og_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :downloads_blank_icon, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }

  belongs_to :country
end
