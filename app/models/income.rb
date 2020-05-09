class Income < ApplicationRecord
  has_many :income_values, dependent: :destroy
end
