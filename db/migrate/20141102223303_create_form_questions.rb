class CreateFormQuestions < ActiveRecord::Migration
  def change
    create_table :form_questions do |t|
      t.integer :template_id
      t.text :question

      t.timestamps
    end
  end
end
