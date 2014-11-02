class AddDescriptionToModel < ActiveRecord::Migration
  def change
        add_column :templates, :description, :text
  end
end
