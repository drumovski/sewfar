# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_save :capital_letter_name

  has_many :patterns
  has_one :seller
  has_one_attached :picture
  has_many :transactions

  validates_uniqueness_of :username
  validates_confirmation_of :active
  validate :avatar_type

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  # soft delete used due to wanting to keep any patterns from being orphaned.

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

  # capitilise name
  def capital_letter_name
    self.name = name.titleize
  end

  private

  # custom validation for avatar
  def avatar_type
    #avatar must be one jpg, jpeg or png
    if picture.attached? == true
      puts "image content type is #{picture.content_type}"
      unless picture.content_type.in?(%('image/jpeg image/png image/jpg'))
        errors.add(:base, 'picture needs to be a jpg, jpeg or png')
      end
    end
  end
end
