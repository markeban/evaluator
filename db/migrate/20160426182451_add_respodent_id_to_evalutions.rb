class AddRespodentIdToEvalutions < ActiveRecord::Migration
  def change
    add_column :respondents, :evaluation_id, :integer
  end
end
