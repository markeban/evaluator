class MoveProFromSubscriberToUser < ActiveRecord::Migration
  def change
    add_column :users, :pro, :boolean
    # Subscription.all.each do |respondent|
    #   respondent.user.pro = respondent.active if respondent.user
    # end
    # remove_column :respondents, :active, :boolean
  end
end
