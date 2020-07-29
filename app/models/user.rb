class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates_uniqueness_of :username
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :patterns
  has_one :seller

  # def self.make_patterns_free
  #   current_user.patterns.each do |pattern|
  #     pattern.price = 0
  #   end
  #   current_user.save
  # end

end
