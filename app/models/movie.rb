class Movie < ApplicationRecord
  has_many :ratings, dependent: :destroy

  scope :title_search, ->(title) { where('title ILIKE ?', "%#{title}%") }

  def self.select_with_rating
    movies = self.select('movies.*, round(avg(ratings.grade), 2) rating').left_outer_joins(:ratings).group('id')
    movies.empty? ? raise(ActiveRecord::RecordNotFound) : movies
  end
end
