# frozen_string_literal: true

class Seller < ApplicationRecord
  belongs_to :user

  validates_uniqueness_of :user_id
  validates :business_name, :address_line_1, :postcode, :city, presence:true
end
