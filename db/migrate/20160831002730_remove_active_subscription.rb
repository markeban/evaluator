class RemoveActiveSubscription < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :active, :boolean
  end
end
