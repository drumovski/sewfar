class AdminController < ApplicationController

  #created this to allow admin to delete other users and not themselves
  
    def admin_delete
        user = User.find(params[:id])
        #make all patterns the user owns free
        user.patterns.each do |pattern|
          pattern.price = 0
          pattern.save
        end
        #remove profile pic
        user.picture.purge
        #remove seller if user is one (could not do via model dependency due to soft delete)
        if user.seller
          user.seller.destroy
        end
        #used soft delete method due to patterns needing to remain active if people have purchesed them
        user.soft_delete
        respond_to do |format|
          format.html { redirect_to sellers_path, notice: 'User was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
      
end