class Spree::Contact < ApplicationRecord
  acts_as_list

  has_attached_file :icon,
                    url: '/spree/contacts/:id/icons/:style/:basename.:extension',
                    path: ':rails_root/public/spree/contacts/:id/icons/:style/:basename.:extension'

  do_not_validate_attachment_file_type :icon
  include DeletableAttachment

  validates :title, presence: true

  default_scope { order(:position) }
end

# == Schema Information
#
# Table name: spree_contacts
#
#  created_at            :datetime         not null
#  faq_link              :string
#  faq_text              :string
#  icon_content_type     :string
#  icon_file_name        :string
#  icon_file_size        :integer
#  icon_updated_at       :datetime
#  id                    :bigint(8)        not null, primary key
#  phone                 :string
#  position              :integer
#  text                  :text
#  title                 :string
#  updated_at            :datetime         not null
#  working_hours_mon_sat :string
#  working_hours_sun     :string
#
