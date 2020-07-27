class Pattern < ApplicationRecord
  belongs_to :user
  enum difficulty: {easy: 0, medium: 1, hard: 2}
end
