class ChangeAnswerModelEvaluationIdtoSubmissionId < ActiveRecord::Migration
  def change
    rename_column :answers, :evaluation_id, :submission_id
  end
end
