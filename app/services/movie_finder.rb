class MovieFinder
  attr_reader :search_keyword, :category, :rating, :page, :movie_scope

  def initialize(search_keyword: nil, category: nil, rating: nil, page: nil)
    @search_keyword = search_keyword
    @category = category
    @rating = rating
    @page = page
  end

  def get!
    @movie_scope = Movie.all
    @movie_scope = filter_by_search if search_keyword.present?
    @movie_scope = filter_by_ratings if rating
    @movie_scope = filter_by_categories if category
    category_groups = build_category_groups
    rating_groups = build_rating_groups
    @movie_scope = @movie_scope.order('average_rating DESC NULLS LAST').page page
    [@movie_scope, category_groups, rating_groups]
  end

  private

  def filter_by_search
    @movie_scope.search(search_keyword).records
  end

  def filter_by_categories
    @movie_scope.in_category(category)
  end

  def filter_by_ratings
    #TODO: see if average_rating can be casted to integer and matched with param
    @rating = rating.to_f
    if rating.eql?(0.0)
      @movie_scope.where("average_rating IS NULL or average_rating BETWEEN ? AND ?", rating, rating+0.99)
    else
      @movie_scope.where(average_rating: (rating..rating+0.99))
    end
  end

  def build_category_groups
    #TODO: optimize this method to minimize queries
    categories = Category.joins(:movies).group(:category_id).count(:category_id)
    categories = categories.transform_keys { |id| Category.find id }
    categories
  end

  def build_rating_groups
    rating_groups = { 5 => 0, 4 => 0, 3 => 0, 2 => 0, 1 => 0, nil => 0}
    ratings = @movie_scope.group("CAST (average_rating AS integer)").count(:id)
    rating_groups.merge(ratings)
  end
end
