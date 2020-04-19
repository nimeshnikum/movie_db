class RatingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:new, :create, :edit, :update]

  # this is actually an upsert operation which would update the existing rating or create new
  def create
    @rating = @movie.ratings.find_or_initialize_by(user_id: current_user.id)
    @rating.attributes = rating_params

    if @rating.save
      render partial: 'movies/movie_row', locals: { movie: @movie }, status: 200
    else
      render partial: 'movies/movie_row', locals: { movie: @movie }, status: 400
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def rating_params
    params.permit(:rating)
  end
end
