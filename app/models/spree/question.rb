class Spree::Question < ApplicationRecord
  acts_as_list

  default_scope { order(:position) }

  belongs_to :category, class_name: 'Spree::QuestionsCategory'

  validates :question, presence: true
  validates :answer, presence: true
end

# == Schema Information
#
# Table name: spree_questions
#
#  answer      :text
#  category_id :integer
#  created_at  :datetime         not null
#  id          :bigint(8)        not null, primary key
#  position    :integer
#  question    :text
#  updated_at  :datetime         not null
#
