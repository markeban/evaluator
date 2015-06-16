class AddUserIdToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :user_id, :string
  end
end
