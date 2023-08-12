# app/controllers/payments_controller.rb
class Api::V1::PaymentsController < ApplicationController
    before_action :authenticate_user!
    def create_payment
      # Get the Stripe token and other parameters from the request
      token = params[:stripeToken]
      amount = params[:amount]
      quantity = params[:quantity]
      description = params[:description]
  
      # Create a customer in Stripe
      customer = Stripe::Customer.create(
        email: current_user.email,
        source: token
      )
  
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


 
      
  
 
  end
  