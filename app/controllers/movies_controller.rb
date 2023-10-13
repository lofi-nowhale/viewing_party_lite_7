class MoviesController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    if params[:search_by_movie_title]
      @movies = MovieFacade.search(params[:search_by_movie_title])
    else
      @movies = MovieFacade.top_rated_movies
    end
  end

  def show
    @movie = MovieFacade.find(params[:id])
  end
end
