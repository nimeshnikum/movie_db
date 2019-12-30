class CreateCategoriesMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_movies do |t|
      t.integer :movie_id
      t.integer :category_id
    end
  end
end
