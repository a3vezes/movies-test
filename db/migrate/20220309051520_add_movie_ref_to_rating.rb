class AddMovieRefToRating < ActiveRecord::Migration[6.1]
  def change
    remove_column :ratings, :movie_id, :bigint
    add_reference :ratings, :movie, null: false, foreign_key: true
  end
end
