class Redactor2Rails::Image < Redactor2Rails::Asset
  has_attached_file :data,
                    styles: { admin: '100x100>', thumb: '100x100>', normal: '1600x900>' },
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                    url: '/spree/redactor_images/:id/data/:style/:basename.:extension',
                    path: ':rails_root/public/spree/redactor_images/:id/data/:style/:basename.:extension',
                    default_style: :normal

  validates_attachment :data,
                       presence: true,
                       content_type: { content_type: %w[image/jpg image/jpeg image/png image/gif] }

  def url_content
    url(:normal)
  end
end

# == Schema Information
#
# Table name: redactor2_assets
#
#  assetable_id      :integer
#  assetable_type    :string(30)
#  created_at        :datetime         not null
#  data_content_type :string
#  data_file_name    :string
#  data_file_size    :integer
#  data_updated_at   :datetime
#  height            :integer
#  id                :bigint(8)        not null, primary key
#  type              :string(30)
#  updated_at        :datetime         not null
#  width             :integer
#
# Indexes
#
#  idx_redactor2_assetable       (assetable_type,assetable_id)
#  idx_redactor2_assetable_type  (assetable_type,type,assetable_id)
#
