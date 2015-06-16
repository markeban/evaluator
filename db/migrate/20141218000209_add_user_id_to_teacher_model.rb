class AddUserIdToTeacherModel < ActiveRecord::Migration
  def change
    add_column :teachers, :user_id, :integer
  end
end
