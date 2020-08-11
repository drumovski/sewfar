class SellersController < ApplicationController
  before_action :set_seller, only: [:show, :edit, :update, :destroy]
  #admin use only
  before_action :authorise_index, only: [:index]
  #admin and the seller themselves only
  before_action :authorise_change, only: [:edit, :update, :destroy]


  def index # admin use only (for seeing/editing all users and sellers)
    @sellers = Seller.all
    @users = User.all
  end

  def show
  end

  def new
    @seller = Seller.new
  end

  def edit
  end

  def create    
    @seller = Seller.new(seller_params)

    #create link between seller and user
    @seller.user_id = current_user.id

    #error checking before save
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

  def update
    #error checking before save
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

  def destroy
    #boolean for seller check
    @seller.user.is_seller = false
    @seller.user.save

    #make all patterns the user owns free due to patterns needing to remain active if people have purchesed them
    @seller.user.patterns.each do |pattern|
      pattern.price = 0
      pattern.save
    end

    #delete seller
    @seller.destroy

    #confirmation message
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

    def authorise_index #authorise admin use only (for seeing all users and sellers)
      if !user_signed_in? || (user_signed_in? && !current_user.admin)
        redirect_to patterns_path
     end
    end

    def authorise_change #authorise admin and the seller themselves only
      if !user_signed_in? || (@seller.user_id != current_user.id && !current_user.admin)
        redirect_to patterns_path
      end
    end
end
