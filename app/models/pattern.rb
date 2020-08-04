class Pattern < ApplicationRecord
  belongs_to :user
  enum difficulty: {easy: 0, medium: 1, hard: 2}
  enum category: {women: 0, men: 1, unisex: 2, kids: 3, toys: 4}
  belongs_to :garment
  has_many_attached :pictures
  has_many_attached :files
  has_many :transactions

end
