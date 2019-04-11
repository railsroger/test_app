class Spree::Subscriber < ApplicationRecord
  validates :email, presence: true
end

# == Schema Information
#
# Table name: spree_subscribers
#
#  created_at :datetime         not null
#  email      :string
#  id         :bigint(8)        not null, primary key
#  updated_at :datetime         not null
#
