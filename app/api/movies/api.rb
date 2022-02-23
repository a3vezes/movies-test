module Movies
  class API < Grape::API
    version 'v1', using: :path
    prefix "api"
    format :json

    resource :movies do
      desc 'returns all movies'
      get do
        Movie.select_with_rating
      end

      desc 'searches a movie using title'
      params do
        optional :title, type: String, desc: 'search term'
      end

      get '/search' do
        Movie.select_with_rating.title_search(params[:title])
      end

      desc 'Show information about a particular movie'
      params do
        requires :id, type: String, desc: 'movie ID.'
      end

      get '/:id' do
        Movie.find_by_id!(params[:id])
      end

      desc 'Create a movie.'
      params do
        requires :title, type: String, desc: 'Movie title.'
        requires :release_date, type: Date, desc: 'Movie release date'
        optional :runtime, type: String, desc: 'Movie runtime'
        optional :genre, type: String, desc: 'Movie genre'
        optional :parental_rating, type: String, desc: 'Movie'
        optional :plot, type: String, desc: 'Movie'
      end

      post do
        Movie.create!({
          title: params[:title],
          release_date: params[:release_date],
          runtime: params[:runtime],
          genre: params[:genre],
          parental_rating: params[:parental_rating],
          plot: params[:plot]
        })
      end

      desc 'Delete a movie.'
      params do
        requires :id, type: String, desc: 'movie ID.'
      end
      delete ':id' do
        Movie.find(params[:id]).destroy
      end
    end
  end
end
