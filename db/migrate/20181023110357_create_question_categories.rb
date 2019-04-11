class CreateQuestionCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_questions_categories do |t|
      t.integer :position
      t.string :name

      t.timestamps
    end
  end
end
