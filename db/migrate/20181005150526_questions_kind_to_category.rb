class QuestionsKindToCategory < ActiveRecord::Migration[5.1]
  def change
    remove_column :spree_questions, :kind, :integer
    add_column :spree_questions, :category_id, :integer
  end
end
