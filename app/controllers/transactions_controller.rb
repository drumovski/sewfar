class TransactionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

    def success

    end

    def webhook
        payment_id= params[:data][:object][:payment_intent]
        payment = Stripe::PaymentIntent.retrieve(payment_id)
        pattern_id = payment.metadata.pattern_id
        user_id = payment.metadata.user_id
        price = payment.metadata.price
    
        p "pattern id " + pattern_id
        p "user id " + user_id
        p "price " + price
    
        head :ok

        transaction = Transaction.new
        transaction.user_id = user_id
        transaction.pattern_id = pattern_id
        transaction.price = price
        transaction.successful = true
        transaction.save
    end
    
end



