class MoveBrainTreeSubscriptionDetailsToSubs < ActiveRecord::Migration
  def change
    remove_column :users, :braintree_customer_id, :integer
    remove_column :subscriptions, :start_date, :date
    remove_column :subscriptions, :expires_on, :date
    add_column :subscriptions, :braintree_customer_id, :integer
    add_column :subscriptions, :braintree_subscription_id, :string
  end
end
