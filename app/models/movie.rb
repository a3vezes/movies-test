class Movie < ApplicationRecord
  has_many :ratings, dependent: :destroy
end
