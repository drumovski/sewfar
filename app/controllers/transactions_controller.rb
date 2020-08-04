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

        transaction = Transaction.create(user_id: user_id, pattern_id: pattern_id, price: price, successful: true)
        transaction.save
        puts "----------------------------------------------------------------------"
        puts transaction      
    end
    
    private

    # def transaction_save(pattern_id, user_id, price)

    #     transaction = Transaction.create(user_id: user_id, pattern_id: pattern_id, price: price)
    #     transaction.save
    #  puts "----------------------------------------------------------------------"
    #  puts transaction
    # end



end



