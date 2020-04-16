class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @movies = Movie.all
    @categories = Category.includes(:movies).select { |c| c.movies.count > 0 }
    @group_by_ratings = @movies.group_by(&:average_rating)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
