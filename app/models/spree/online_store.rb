class Spree::OnlineStore < ApplicationRecord
  acts_as_list

  default_scope { order(:position) }

  validates :name, presence: true
  validates :url, presence: true

  before_validation :grab_favicon

  def grab_favicon
    self.favicon_url = Pismo::Document.new(url).favicon
    rescue Exception
  end
end

# == Schema Information
#
# Table name: spree_online_stores
#
#  created_at  :datetime         not null
#  favicon_url :string
#  id          :bigint(8)        not null, primary key
#  name        :string
#  position    :integer
#  updated_at  :datetime         not null
#  url         :string
#
