Spree::Taxon.class_eval do

  has_attached_file :bg_image,
                    styles: { admin: '100x100>', normal: '1920x1024>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/taxons/:id/bg_images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/taxons/:id/bg_images/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :image,
                    styles: { admin: '100x100>', normal: '960x960>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/taxons/:id/images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/taxons/:id/images/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :support_icon,
                    url: '/spree/taxons/:id/support_icons/:style/:basename.:extension',
                    path: ':rails_root/public/spree/taxons/:id/support_icons/:style/:basename.:extension'

  has_attached_file :left_banner_image,
                    styles: { admin: '100x100>', normal: '960x960>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/taxons/:id/left_banner_images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/taxons/:id/left_banner_images/:style/:basename.:extension',
                    default_style: :normal

  has_attached_file :right_banner_image,
                    styles: { admin: '100x100>', normal: '960x960>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/taxons/:id/right_banner_images/:style/:basename.:extension',
                    path: ':rails_root/public/spree/taxons/:id/right_banner_images/:style/:basename.:extension',
                    default_style: :normal

  validates_attachment :bg_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :support_icon, less_than: 1.megabytes
  do_not_validate_attachment_file_type :support_icon
  validates_attachment :left_banner_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  validates_attachment :right_banner_image, content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }
  include DeletableAttachment

  belongs_to :filter1, class_name: 'Spree::Property', optional: true
  belongs_to :filter2, class_name: 'Spree::Property', optional: true
  belongs_to :filter3, class_name: 'Spree::Property', optional: true
  belongs_to :filter4, class_name: 'Spree::Property', optional: true

  has_many :left_menu_items, class_name: 'Spree::TaxonsLeftMenuItem', dependent: :destroy, inverse_of: :taxon
  has_many :right_menu_items, class_name: 'Spree::TaxonsRightMenuItem', dependent: :destroy, inverse_of: :taxon

  accepts_nested_attributes_for :left_menu_items, reject_if: ->(ov) { ov[:name].blank? || ov[:link].blank? }, allow_destroy: true
  accepts_nested_attributes_for :right_menu_items, reject_if: ->(ov) { ov[:name].blank? || ov[:link].blank? }, allow_destroy: true

  scope :for_sitemap, -> { where hide_from_sitemap: false }

  def applicable_filters
    fs = []
    (1..4).each do |n|
      filter = send(:"filter#{n}")
      next unless filter && Spree::Core::ProductFilters.respond_to?(:"#{filter.name}_filter")
      fs << Spree::Core::ProductFilters.send((:"#{filter.name}_filter"))
    end
    fs
  end
end
