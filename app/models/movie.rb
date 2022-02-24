class Movie < ApplicationRecord
  has_many :ratings, dependent: :destroy
  scope :title_search, ->(title) { where("title ILIKE '%#{title}%'") }

  def self.select_with_rating
    self.select('movies.*, round(avg(ratings.grade), 2) rating').includes(:ratings  ).left_outer_joins(:ratings).group("id")
  end
end
