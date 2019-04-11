class Spree::File < ApplicationRecord
  has_attached_file :attachment,
                    url: '/spree/files/:id/attachments/:style/:basename.:extension',
                    path: ':rails_root/public/spree/files/:id/attachments/:style/:basename.:extension'

  validates_attachment :attachment, presence: true
  do_not_validate_attachment_file_type :attachment
  include DeletableAttachment

  validates :name, presence: true
end

# == Schema Information
#
# Table name: spree_files
#
#  attachment_content_type :string
#  attachment_file_name    :string
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  created_at              :datetime         not null
#  id                      :bigint(8)        not null, primary key
#  name                    :string
#  updated_at              :datetime         not null
#
