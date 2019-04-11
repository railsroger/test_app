Spree::Property.class_eval do
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :presentation, presence: true, uniqueness: { case_sensitive: false }
  validates :group, presence: true

  belongs_to :property, required: true, class_name: 'Spree::Property'
end
