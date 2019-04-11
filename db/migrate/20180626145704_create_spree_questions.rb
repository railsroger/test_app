class CreateSpreeQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_questions do |t|
      t.integer :position
      t.integer :kind
      t.text :question
      t.text :answer

      t.timestamps
    end
  end
end
