class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_categories, only: [:new, :create, :edit, :update]
  before_action :set_movie, only: [:edit, :update, :destroy]

  def index
    @movies, @category_groups, @rating_groups = MovieFinder.new(
                                                  category: params[:category],
                                                  rating: params[:rating],
                                                  page: params[:page]
                                                ).get!
  end

  def new
    @movie = current_user.movies.build
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      flash[:notice] = 'Movie was successfully created'
      redirect_to movies_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @movie.update_attributes(movie_params)
      flash[:notice] = 'Movie was successfully updated'
      redirect_to movies_path
    else
      render :edit
    end
  end

  def destroy
    if @movie.destroy
      flash[:notice] = 'Movie was successfully deleted'
      redirect_to movies_path
    else
      render :index
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :text, category_ids: [])
  end

  def load_categories
    @categories = Category.all
  end

  def set_movie
    @movie = current_user.movies.find(params[:id])
  end
end
