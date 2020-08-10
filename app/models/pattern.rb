# frozen_string_literal: true

class Pattern < ApplicationRecord
  belongs_to :user
  belongs_to :garment
  has_many_attached :pictures
  has_one_attached :file
  has_many :transactions

  enum difficulty: { easy: 0, medium: 1, hard: 2 }
  enum category: { women: 0, men: 1, unisex: 2, kids: 3, toys: 4 }

  validates :name, :sizes, :garment, :category, :price, :description, :difficulty, presence: true

  validate :image_type
  validate :pdf_type

  # validations for active storage (from active storage gem - https://github.com/igorkasyanchuk/active_storage_validations)
  # this ended up breaking my code so I removed it- prevented changing the price of patterns to 0 after deleting seller or user. No clue why.
  # ended up using custom private methods below it

  # validates :pictures, content_type: {in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'should be a jpg or png'},
  #                      limit: { min: 1, max: 6, message: 'limit of 6 images' },
  #                      size: { less_than: 5.megabytes, message: 'must be less than 5MB in size' }

  # validates :file, content_type: { in: 'application/pdf', message: 'must be a PDF' },
  #                  size: { less_than: 5.megabytes, message: 'must be less than 5MB in size' }

  private

  def image_type
    puts '+++++++++++++++++++++++++++++++++++in image_type++++++++++++++++++++'
    if pictures.attached? == false
      puts '+++++++++++++++++++++++++++++++++++in image first loop++++++++++++++++++++'
      errors.add(:base, 'You need to include at least one picture!')
    else
      i = 0
      pictures.each do |image|
        puts '+++++++++++++++++++++++++++++++++++in image second loop++++++++++++++++++++'
        puts "image content type true/false #{!image.content_type.in?(%('image/jpeg image/png image/jpg'))}"
        puts "image content type is #{image.content_type}"
        i += 1
        puts i
        errors.add(:base, 'maximum number of pictures is 6') if i > 6
        next if image.content_type.in?(%('image/jpeg image/png image/jpg'))

        puts '+++++++++++++++++++++++++++++++++++in image third loop++++++++++++++++++++'
        errors.add(:base, 'pictures need to be a jpg, jpeg or png')
        puts '=========================================================='
      end
    end
    puts "picture errors? #{errors.full_messages}"
  end

  def pdf_type
    puts '+++++++++++++++++++++++++++++++++++in file_type++++++++++++++++++++'
    if file.attached? == false
      puts '+++++++++++++++++++++++++++++++++++in file first loop++++++++++++++++++++'
      errors.add(:base, 'You need to include a pdf file of instructions!')
    else
      puts '+++++++++++++++++++++++++++++++++++in file second loop++++++++++++++++++++'
      puts "file content type is #{file.content_type}"
      unless file.content_type.in?(%('application/pdf application/PDF'))
        puts '+++++++++++++++++++++++++++++++++++in file third loop++++++++++++++++++++'
        errors.add(:base, 'instructions file needs to be a pdf')
        puts '=========================================================='
      end
    end
    puts "file errors? #{errors.full_messages}"
  end
end
