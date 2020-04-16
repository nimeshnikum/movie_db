class AddAverageRatingToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :average_rating, :float
  end
end
