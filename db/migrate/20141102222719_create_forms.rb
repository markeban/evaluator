class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.integer :student_id
      t.integer :template_id

      t.timestamps
    end
  end
end
