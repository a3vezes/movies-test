require 'rails_helper'

RSpec.describe Ratings::API do
  let(:movie) { Movie.create(title: 'test', release_date: Date.today) }

  describe 'POST /api/v1/ratings' do
    it 'adds rating to movie' do
      post '/api/v1/ratings', params: { movie_id: movie.id, grade: 2 }
      expect(response).to have_http_status(:created)
      expect(movie.ratings.count).to eq(1)
    end

    it 'returns a validation error when movie doesnt exists' do
      post '/api/v1/ratings', params: { movie_id: -5, grade: 5 }

      expect(response).to have_http_status(422)
      expect(response.body).to include('Movie must exist')
    end

    it 'returns a validation error when creating a rating without the movie_id' do
      post '/api/v1/ratings', params: { grade: 5 }

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include('movie_id is missing')
    end

    it 'returns a validation error when creating a rating without the rating' do
      post '/api/v1/ratings', params: { movie_id: 5 }

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include('grade is missing')
    end
  end
end
