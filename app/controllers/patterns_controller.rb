# frozen_string_literal: true

class PatternsController < ApplicationController
  before_action :set_pattern, only: %i[show edit update destroy]
  #for admin and pattern owners
  before_action :authorise_change, only: %i[edit update destroy]
  #for sellers
  before_action :authorise_new, only: %i[new create]

  def index
    #send all patterns plus eager loading transactions, garment, user and seller
    @patterns = Pattern.includes(:transactions, :garment, :user => :seller).all
    #compile and send all patterns the current user has purchased
    if user_signed_in?
      @bought_patterns = @patterns.where(id: Transaction.select(:pattern_id).where(user_id: current_user))
      # compile and send all patterns created by the user
      @user_patterns = @patterns.where(user_id: current_user)
    end
  end

  def show
    # stripe code *unless the pattern is free
    if @pattern.price != 0.0 && user_signed_in? 
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: [{
          name: @pattern.name,
          description: @pattern.description,
          amount: (@pattern.price * 100).to_i,
          currency: 'aud',
          quantity: 1
        }],
        payment_intent_data: {
          metadata: {
            user_id: current_user.id,
            pattern_id: @pattern.id,
            price: @pattern.price
          }
        },
        success_url: "#{root_url}transactions/success?user_id=#{current_user.id}&pattern_id=#{@pattern.id}&price=#{@pattern.price}",
        cancel_url: "#{root_url}patterns"
      )
      @session_id = session.id
    end
  end

  def new
    @pattern = Pattern.new
  end

  def edit; end

  def create
    @pattern = current_user.patterns.create(pattern_params)
    #error checking before save
    respond_to do |format|
      if @pattern.save
        format.html { redirect_to @pattern, notice: 'Pattern was successfully created.' }
        format.json { render :show, status: :created, location: @pattern }
      else
        format.html { render :new }
        format.json { render json: @pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    #error checking before save
    respond_to do |format|
      if @pattern.update(pattern_params)
        format.html { redirect_to @pattern, notice: 'Pattern was successfully updated.' }
        format.json { render :show, status: :ok, location: @pattern }
      else
        format.html { render :edit }
        format.json { render json: @pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    #remove all pictures from amazon S3
    @pattern.pictures.purge
    #remove all files from amazon S3
    @pattern.file.purge
    #delete the pattern
    @pattern.destroy
    respond_to do |format|
      format.html { redirect_to patterns_url, notice: 'Pattern was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pattern
    @pattern = Pattern.find(params[:id])
  end

  def authorise_change  #for admin and pattern owners
    if (@pattern.user_id != current_user.id && !current_user.admin) || (!current_user.is_seller && !current_user.admin)
      redirect_to patterns_path
    end
  end

  def authorise_new #for sellers
    redirect_to patterns_path unless current_user.is_seller
  end

  # Only allow a list of trusted parameters through.
  def pattern_params
    params.require(:pattern).permit(:name, :sizes, :fabric, :fabric_amount, :garment_id, :category, :price, :description, :difficulty, :notions, :complete, :file, pictures:[])
  end
end
