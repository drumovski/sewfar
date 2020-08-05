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

  # validations for active storage
  validates :pictures, attached: true,
                       content_type: {in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'should be a jpg or png'},
                       limit: { min: 1, max: 6, message: 'limit of 6 images' },
                       size: { less_than: 5.megabytes, message: 'must be less than 5MB in size' }

  validates :file, attached: true,
                   content_type: { in: 'application/pdf', message: 'must be a PDF' },
                   size: { less_than: 5.megabytes, message: 'must be less than 5MB in size' }
end
