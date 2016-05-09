class AddEmailedToRespondents < ActiveRecord::Migration
  def change
    add_column :respondents, :emailed, :boolean
  end
end
