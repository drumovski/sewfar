# frozen_string_literal: true

class Pattern < ApplicationRecord
  before_create :image_type
  before_update :image_type
  belongs_to :user
  belongs_to :garment
  has_many_attached :pictures
  has_one_attached :file
  has_many :transactions

  enum difficulty: { easy: 0, medium: 1, hard: 2 }
  enum category: { women: 0, men: 1, unisex: 2, kids: 3, toys: 4 }

  validates :name, :sizes, :garment, :category, :price, :description, :difficulty, presence: true

  # validations for active storage (from active storage gem - https://github.com/igorkasyanchuk/active_storage_validations)
  # this ended up breaking my code so I removed it - prevented seeding images and files to patterns
  # and also prevented changing the price of patterns to 0 after deleting seller or user. No clue why. Stupid gem.
  # ended up using custom private methods below it

  # validates :pictures, content_type: {in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'should be a jpg or png'},
  #                      limit: { min: 1, max: 6, message: 'limit of 6 images' },
  #                      size: { less_than: 5.megabytes, message: 'must be less than 5MB in size' }

  # validates :file, content_type: { in: 'application/pdf', message: 'must be a PDF' },
  #                  size: { less_than: 5.megabytes, message: 'must be less than 5MB in size' }


  private

  def image_type
    puts "+++++++++++++++++++++++++++++++++++in image_type++++++++++++++++++++"
    if pictures.attached? == false
      puts "+++++++++++++++++++++++++++++++++++in first loop++++++++++++++++++++"
      errors.add(:base, 'pictures are missing!')
    else
      pictures.each do |image|
        puts "+++++++++++++++++++++++++++++++++++in second loop++++++++++++++++++++"
        puts "image content type true/false #{!image.content_type.in?(%('image/jpeg image/png image/jpg'))}"
        puts "image content type is #{image.content_type}"
        if !image.content_type.in?(%('image/jpeg image/png image/jpg'))
          puts "+++++++++++++++++++++++++++++++++++in third loop++++++++++++++++++++"
          errors.add(:base, 'needs to be a JPG or PNG')        
          puts "=========================================================="        
        end
      end
    end
    puts "picture errors? #{errors.any?}"
  end


end


