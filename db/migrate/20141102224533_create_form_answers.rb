class CreateFormAnswers < ActiveRecord::Migration
  def change
    create_table :form_answers do |t|
      t.integer :form_question_id
      t.integer :form_id
      t.text :answer

      t.timestamps
    end
  end
end
