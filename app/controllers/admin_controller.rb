class AdminController < ApplicationController

    def admin_delete
        user = User.find(params[:id])
        user.patterns.each do |pattern|
          pattern.price = 0
          pattern.save
        end
        user.soft_delete
        respond_to do |format|
          format.html { redirect_to sellers_path, notice: 'User was successfully destroyed.' }
          format.json { head :no_content }
        end
      end
      
end