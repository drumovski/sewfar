class TransactionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

    #actioned upon return from stripe    
    def success
    end

    #actioned upon successful return from stripe via webhook
    def webhook
        payment_id= params[:data][:object][:payment_intent]
        payment = Stripe::PaymentIntent.retrieve(payment_id)
        pattern_id = payment.metadata.pattern_id
        user_id = payment.metadata.user_id
        price = payment.metadata.price
    
        p "pattern id " + pattern_id    #pattern bought (seller can be extrated from this)
        p "user id " + user_id          #user who bought the pattern
        p "price " + price              #price paid 
        head :ok

        transaction = Transaction.create(user_id: user_id, pattern_id: pattern_id, price: price, successful: true)
        transaction.save   
    end

end



