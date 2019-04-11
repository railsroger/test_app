class Spree::Download < ApplicationRecord
  has_attached_file :file,
                    url: '/spree/downloads/:id/files/:style/:basename.:extension',
                    path: ':rails_root/public/spree/downloads/:id/files/:style/:basename.:extension'

  validates_attachment :file,
                       presence: true
  do_not_validate_attachment_file_type :file

  belongs_to :product, class_name: 'Spree::Product', optional: true
  belongs_to :category, class_name: 'Spree::DownloadsCategory'

  validates :name, presence: true
end

# == Schema Information
#
# Table name: spree_downloads
#
#  category_id       :integer
#  created_at        :datetime         not null
#  date              :date
#  description       :string
#  file_content_type :string
#  file_file_name    :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#  id                :bigint(8)        not null, primary key
#  name              :string
#  product_id        :integer
#  updated_at        :datetime         not null
#  version           :string
#
