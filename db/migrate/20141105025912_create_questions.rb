class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.integer :template_id
      t.boolean :required
      t.string :format_type

      t.timestamps
    end
  end
end
