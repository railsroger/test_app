class Spree::Tracker < ApplicationRecord
  validates :name, presence: true

  scope :active, -> { where(active: true) }

  def self.current(engine = TRACKING_ENGINES.first)
    tracker = Rails.cache.fetch("current_tracker/#{engine}") do
      send(engine).active.first
    end
    tracker.code.present? ? tracker : nil if tracker
  end

  def clear_cache
    TRACKING_ENGINES.each do |engine|
      Rails.cache.delete("current_tracker/#{engine}")
    end
  end
end

# == Schema Information
#
# Table name: spree_trackers
#
#  active      :boolean          default(TRUE), not null
#  body_ends   :text
#  body_starts :text
#  created_at  :datetime         not null
#  header      :text
#  id          :bigint(8)        not null, primary key
#  name        :string
#  updated_at  :datetime         not null
#
