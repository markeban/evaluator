class SubscriptionsController < ApplicationController
  def new
    gon.client_token = generate_client_token
  end

  def create
    new_customer = Braintree::Customer.create(
      :first_name => "Charity",
      :last_name => "Smith",
      payment_method_nonce: params[:payment_method_nonce])
    if new_customer.success?
      current_user.update(braintree_customer_id: new_customer.customer.id)
      result = Braintree::Subscription.create(
        :payment_method_token => new_customer.customer.payment_methods[0].token,
        :plan_id => "m34w"
      )
      puts "stuff"
      p result
    else
     flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
     gon.client_token = generate_client_token
     render :new
   end
 end





 private
 def generate_client_token
   if current_user.has_payment_info?
     Braintree::ClientToken.generate(customer_id: current_user.braintree_customer_id)
   else
     Braintree::ClientToken.generate
   end
 end
end
