class AddActiveToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :active, :boolean
  end
end
