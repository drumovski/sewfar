class SellersController < ApplicationController
  before_action :set_seller, only: [:show, :edit, :update, :destroy]
  before_action :authorise_index, only: [:index]
  before_action :authorise_change, only: [:show, :edit, :update, :destroy]

  # GET /sellers
  # GET /sellers.json
  def index
    @sellers = Seller.all
    @users = User.all
  end

  # GET /sellers/1
  # GET /sellers/1.json
  def show
  end

  # GET /sellers/new
  def new
    @seller = Seller.new
  end

  # GET /sellers/1/edit
  def edit
  end

  # POST /sellers
  # POST /sellers.json
  def create    
    @seller = Seller.new(seller_params)
    @seller.user_id = current_user.id
    respond_to do |format|
      if @seller.save
        @seller.user.is_seller = true
        @seller.user.save
        format.html { redirect_to @seller, notice: 'Seller was successfully created.' }
        format.json { render :show, status: :created, location: @seller }
      else
        format.html { render :new }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sellers/1
  # PATCH/PUT /sellers/1.json
  def update
    respond_to do |format|
      if @seller.update(seller_params)
        @seller.user.is_seller = true
        @seller.user.save
        format.html { redirect_to @seller, notice: 'Seller was successfully updated.' }
        format.json { render :show, status: :ok, location: @seller }     
      else
        format.html { render :edit }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sellers/1
  # DELETE /sellers/1.json
  def destroy
    @seller.user.is_seller = false
    @seller.user.save
    # User::make_patterns_free
    @seller.user.patterns.each do |pattern|
      pattern.price = 0
      pattern.save
    end
    @seller.destroy
    respond_to do |format|
      format.html { redirect_to patterns_path, notice: 'Seller was successfully destroyed.' }
      format.json { head :no_content }
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller
      @seller = Seller.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def seller_params
      params.require(:seller).permit(:business_name, :abn, :website, :facebook, :twitter, :linkedin, :instagram, :about, :address_line_1, :address_line_2, :city, :postcode, :country)
    end

    def authorise_index
      if user_signed_in? 
        if !current_user.admin
          redirect_to patterns_path
        end
     end
    end

    def authorise_change
      if (@seller.user_id != current_user.id && !current_user.admin)
        redirect_to patterns_path
      end
    end
end
