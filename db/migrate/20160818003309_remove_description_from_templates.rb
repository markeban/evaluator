class RemoveDescriptionFromTemplates < ActiveRecord::Migration
  def change
    remove_column :templates, :description, :text
  end
end
