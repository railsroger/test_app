module Spree
  class LegalPage < Spree::Base
    extend FriendlyId
    friendly_id :slug_candidates, use: :slugged
    acts_as_list

    default_scope { order(:position) }

    before_validation :normalize_slug, on: :update

    validates :title, presence: true
    validates :html, presence: true
    validates :slug, presence: true, uniqueness: { allow_blank: true }

    private

    # Try building a slug based on the following fields in increasing order of specificity.
    def slug_candidates
      [:title]
    end

    def should_generate_new_friendly_id?
      title_changed? || slug.blank? || super
    end

    def normalize_slug
      self.slug = normalize_friendly_id(slug)
    end
  end
end

# == Schema Information
#
# Table name: spree_legal_pages
#
#  created_at :datetime         not null
#  html       :text
#  id         :bigint(8)        not null, primary key
#  position   :integer
#  slug       :string
#  title      :string
#  updated_at :datetime         not null
#
