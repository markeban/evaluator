class AddSubjectMessageToEvaluations < ActiveRecord::Migration
  def change
    add_column :evaluations, :subject, :text
    add_column :evaluations, :message, :text
  end
end
