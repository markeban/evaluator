class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    gon.client_token = generate_client_token
  end

  def create
    unless current_user.has_payment_info?
      customer = Braintree::Customer.create(
        first_name: params[:first_name],
        last_name: params[:last_name],
        company: params[:company],
        phone: params[:phone],
        payment_method_nonce: params[:payment_method_nonce])
      result = Braintree::Subscription.create(payment_method_token: customer.customer.payment_methods[0].token, plan_id: "m34w")
    else
      result = Braintree::Subscription.create(payment_method_nonce: params[:payment_method_nonce], plan_id: "m34w")
    end
    if result.success?
      if current_user.has_payment_info?
        @subscription = Subscription.find(current_user.subscription.id)
        @subscription.update(braintree_subscription_id: result.subscription.id)
      else
      @subscription = Subscription.create(user_id: current_user.id, braintree_customer_id: result.subscription.transactions[0].customer_details.id, braintree_subscription_id: result.subscription.id)
      end
      @subscription.user.update(pro: true)
      flash[:success] = "Subscription successful!"
      redirect_to "/account?billing=active"
    else
     flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
     gon.client_token = generate_client_token
     render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
    @braintree = Braintree::Subscription.find(@subscription.braintree_subscription_id)
  end

  def destroy
    subscription = Subscription.find(params[:id])
    result = Braintree::Subscription.cancel(subscription.braintree_subscription_id)
    if result.success?
      subscription.user.update(pro: false)
      flash[:success] = "Subscription Canceled"
      redirect_to "/account?billing=active"
    else
      flash[:danger] = "Subscription NOT Canceled"
      redirect_to "/account?billing=active"
    end
  end

  private

  def generate_client_token
    if current_user.has_payment_info?
     Braintree::ClientToken.generate(customer_id: current_user.subscription.braintree_customer_id)
    else
     Braintree::ClientToken.generate
    end
  end

end
