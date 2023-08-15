# app/controllers/payments_controller.rb
class Api::V1::PaymentsController < ApplicationController
    before_action :authenticate_user!
    def create_payment
      # Get the Stripe token and other parameters from the request
      token = params[:stripeToken]
      amount = params[:amount]
      quantity = params[:quantity]
      description = params[:description]
      subs_id= params[:id]
  
      # Create a customer in Stripe
      customer = Stripe::Customer.create(
        email: current_user.email,
        source: token
      )

      if subs_id==2
        subscription = Stripe::Subscription.create(customer: customer.id, items: [{ price: 'price_1NfF3kSHgvt1vXucuBVIiK5s' }])
        
      elsif subs_id==3 
        subscription = Stripe::Subscription.create(customer: customer.id, items: [{ price: 'price_1NfF4aSHgvt1vXucXBNzyRWz' }])

      else
        subscription = Stripe::Subscription.create(customer: customer.id, items: [{ price: 'price_1NfF5ZSHgvt1vXuc5ysDYF3U' }])
      end 
      @subs = Subscription.find(subs_id)
      current_user.update(subscription :@subs , stripe_customer_id: customer.id)

     
  /
      # Create a charge in Stripe
      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: amount,
        description: description,
        currency: 'usd'
      )
  
      # Create an order in your database
      order = current_user.orders.create(
        amount: amount,
        charge_id: charge.id
      )
      payment_status = nil
      if charge.paid
        payment_status = 'paid'
      elsif charge.payment_failure_code
        payment_status = 'failed'
      else
        payment_status = 'pending'
      end
  
      # Return a success response to the client
      render json: { success: true, message: 'Payment successful', order_id: order.id, payment_status: payment_status }
    rescue Stripe::CardError => e
      # Handle card errors
      render json: { success: false, message: e.message }
    end

/
payment_intent = Stripe::PaymentIntent.retrieve(subscription.latest_invoice.payment_intent)
if payment_intent.status == "succeeded"
  return { success: true, message: "Subscription successfully created and payment is successful!" }
else
  return { success: false, message: "Subscription created, but payment is pending or failed." }
end
rescue Stripe::StripeError => e
return { success: false, message: "An error occurred while creating subscription: #{e.message}" }
end

end
      
  
 
  end
  