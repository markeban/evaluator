class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:account]

  def index
    # render layout: "landing_page"
  end

  def chart
  end

  def pricing
  end

  def how_it_works
    
  end

  def account
    @braintree_subscription = Braintree::Subscription.find(current_user.subscription.braintree_subscription_id) if current_user.pro
  end
end
