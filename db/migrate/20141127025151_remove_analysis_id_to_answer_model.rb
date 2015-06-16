class RemoveAnalysisIdToAnswerModel < ActiveRecord::Migration
  def change
    remove_column :answers, :analysis_id, :integer
  end
end
