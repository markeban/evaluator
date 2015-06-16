class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :template_id
      t.integer :teacher_id
      t.string :url

      t.timestamps
    end
  end
end
