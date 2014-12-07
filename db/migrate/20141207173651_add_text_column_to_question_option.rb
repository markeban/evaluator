class AddTextColumnToQuestionOption < ActiveRecord::Migration
  def change
    add_column :question_options, :text, :string
  end
end
