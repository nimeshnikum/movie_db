module MoviesHelper
  def rating_group(rating, movie_count)
    rating_title = rating.to_i.eql?(0) ? 'Not rated' : "#{rating.to_i} stars"
    "#{rating_title} (#{movie_count})"
  end

  def highlight_current(rating, current_rating)
    'font-weight-bold' if rating.to_i == current_rating.to_i
  end
end
