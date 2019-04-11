class Spree::QuestionsCategory < ApplicationRecord
  acts_as_list

  validates :name, presence: true

  default_scope { order(:position) }
end

# == Schema Information
#
# Table name: spree_questions_categories
#
#  created_at :datetime         not null
#  id         :bigint(8)        not null, primary key
#  name       :string
#  position   :integer
#  updated_at :datetime         not null
#
