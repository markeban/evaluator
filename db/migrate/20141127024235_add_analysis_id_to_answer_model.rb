class AddAnalysisIdToAnswerModel < ActiveRecord::Migration
  def change
    add_column :answers, :analysis_id, :integer
  end
end
