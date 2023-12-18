class MoviesController < ApplicationController
  require 'dotenv/load'
  require 'httparty'

  def search
    @query = params[:query]
    if @query.present?
      @movies = search_movies(@query)
    else
      @movies = []
    end
  end

  private

  def search_movies(query)
    api_key = ENV['TMDB_API_KEY']
    base_url = 'https://api.themoviedb.org/3'
    search_url = "#{base_url}/search/movie"

    response = HTTParty.get(search_url, query: { api_key: api_key, query: query })
    results = JSON.parse(response.body)['results']

    results.map { |result| Movie.new(title: result['title'], overview: result['overview']) }
  end
end