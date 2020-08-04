class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates_uniqueness_of :username
  validates_confirmation_of :active
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :patterns
  has_one :seller
  has_one_attached :picture
  has_many :transactions

  # def self.make_patterns_free
  #   current_user.patterns.each do |pattern|
  #     pattern.price = 0
  #   end
  #   current_user.save
  # end

    # instead of deleting, indicate the user requested a delete & timestamp it  
    def soft_delete  
      update_attribute(:deleted_at, Time.current)  
    end  
    
    # ensure user account is active  
    def active_for_authentication?  
      super && !deleted_at  
    end  
    
    # provide a custom message for a deleted account   
    def inactive_message   
      !deleted_at ? super : :deleted_account  
    end  
end
