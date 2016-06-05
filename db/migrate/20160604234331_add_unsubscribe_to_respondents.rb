class AddUnsubscribeToRespondents < ActiveRecord::Migration
  def change
    add_column :respondents, :unsubscribed_to_user, :boolean
    add_column :respondents, :unsubscribed_to_all, :boolean
  end
end
