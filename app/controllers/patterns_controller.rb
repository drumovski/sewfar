# frozen_string_literal: true

class PatternsController < ApplicationController
  before_action :set_pattern, only: %i[show edit update destroy]
  before_action :authorise_change, only: %i[edit update destroy]
  before_action :authorise_new, only: %i[new create]
  before_action :authorise_destroy, only: [:destroy]

  # GET /patterns
  # GET /patterns.json
  def index
    @patterns = Pattern.all
    if user_signed_in?
      @bought_patterns = []
      current_user.transactions.each do |transaction|
        @bought_patterns << transaction.pattern
      end
      @bought_patterns
    end
  end

  # GET /patterns/1
  # GET /patterns/1.json
  def show
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

  # GET /patterns/new
  def new
    @pattern = Pattern.new
  end

  # GET /patterns/1/edit
  def edit; end

  # POST /patterns
  # POST /patterns.json
  def create
    # @pattern = Pattern.new(pattern_params)
    @pattern = current_user.patterns.create(pattern_params)
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

  # PATCH/PUT /patterns/1
  # PATCH/PUT /patterns/1.json
  def update
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

  # DELETE /patterns/1
  # DELETE /patterns/1.json
  def destroy
    @pattern.pictures.purge
    @pattern.file.purge
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

  def authorise_change
    if (@pattern.user_id != current_user.id && !current_user.admin) || (!current_user.is_seller && !current_user.admin)
      redirect_to patterns_path
    end
  end

  def authorise_destroy
    redirect_to patterns_path if @pattern.complete && !current_user.admin
  end

  def authorise_new
    redirect_to patterns_path unless current_user.is_seller
  end

  # Only allow a list of trusted parameters through.
  def pattern_params
    params.require(:pattern).permit(:name, :sizes, :fabric, :fabric_amount, :garment_id, :category, :price, :description, :difficulty, :notions, :complete, :file, pictures:[])
  end
end
