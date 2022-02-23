class Movie < ApplicationRecord
  has_many :ratings, dependent: :destroy

  def self.select_with_rating
    self.select('movies.*, round(avg(ratings.grade), 2) rating').joins(:ratings).group("id")
  end
end
