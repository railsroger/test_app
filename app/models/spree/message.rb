class Spree::Message < ApplicationRecord
  attr_accessor :reason, :email, :address, :name, :phone, :message,
                :country, :region, :city, :post_code, :product_type,
                :date_of_purchase, :retailer, :model_number, :serial_number,
                :subscribe

  before_validation :set_attrs

  def set_attrs
    self.subject = reason
    self.full_message = ''
    %i[email address name phone message
       country region city post_code product_type
       date_of_purchase retailer model_number serial_number
       subscribe].each do |attr|
      val = send(attr)
      full_message << "#{attr.to_s.humanize}: #{val}\r\n" if val
    end
  end
end

# == Schema Information
#
# Table name: spree_messages
#
#  created_at   :datetime         not null
#  full_message :text
#  id           :bigint(8)        not null, primary key
#  subject      :string
#  updated_at   :datetime         not null
#
