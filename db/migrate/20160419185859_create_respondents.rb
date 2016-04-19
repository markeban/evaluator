class CreateRespondents < ActiveRecord::Migration
  def change
    create_table :respondents do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :responded

      t.timestamps null: false
    end
  end
end
