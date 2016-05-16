class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.date :start_date
      t.date :expires_on
      t.integer :user_id

      t.timestamps null: true
    end
  end
end
