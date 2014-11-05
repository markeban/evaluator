class DropFormTableAndFormAnswersAndFormQuestions < ActiveRecord::Migration
  def up
    drop_table :form_answers
    drop_table :form_questions
    drop_table :forms
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
