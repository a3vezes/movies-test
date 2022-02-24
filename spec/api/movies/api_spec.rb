require 'rails_helper'

RSpec.describe Movies::API do
  let!(:movie) { Movie.create(title: "teste", release_date: Date.today) }
  let!(:movie2) { Movie.create(title: "teste2", release_date: Date.tomorrow) }

  describe 'GET /api/v1/movies' do
    it 'returns all movies' do
      get "/api/v1/movies/"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("teste")
      expect(response.body).to include("teste2")
    end
  end

  describe 'GET /api/v1/movies/search' do
    it 'returns searched movie' do
      get "/api/v1/movies/search?title=teste2"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("teste2")
    end

    it 'returns 404 if movie doesnt exists' do
      get "/api/v1/movies/search?title=teste5"
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include("not_found")
    end
  end

  describe 'GET /api/v1/movies/:id' do
    it 'returns movie using id' do
      get "/api/v1/movies/#{movie2.id}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("teste2")
    end
  end

  describe 'POST /api/v1/movies' do
    it 'returns movie using id' do
      post "/api/v1/movies", :params => { :title => "Any Name", release_date: Date.yesterday }
      expect(response).to have_http_status(:created)
      expect(Movie.count).to eq(3)
    end

    it 'returns validation error when creating without release_date' do
      post "/api/v1/movies", :params => { :title => "Any Name" }
      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include('release_date is missing')
    end

    it 'returns validation error when creating without title' do
      post "/api/v1/movies", :params => { release_date: Date.yesterday }
      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include('title is missing')
    end
  end

  describe 'DELETE /api/v1/movies' do
    it 'remove movie' do
      delete "/api/v1/movies/#{movie2.id}"
      expect(response).to have_http_status(:ok)
      expect(Movie.count).to eq(1)
    end
  end

  describe 'Movie Rating' do
    subject(:rating_movie) { Movie.create(title: "rating", release_date: Date.tomorrow) }

    it 'calculates rates correctly' do
      post "/api/v1/ratings", :params => { movie_id: rating_movie[:id], grade: 4 }
      post "/api/v1/ratings", :params => { movie_id: rating_movie[:id], grade: 2 }

      get "/api/v1/movies/#{rating_movie.id}"

      expect(response.body).to include("3.0")
    end
  end
end
