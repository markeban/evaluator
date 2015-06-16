class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :evaluation_id
      t.integer :user_id

      t.timestamps
    end
  end
end
