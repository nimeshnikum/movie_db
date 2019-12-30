class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title

      t.timestamps
    end

    categories = %w(
      Action Adventure Animation Biography Comedy Crime Documentary Drama Family
      Fantasy History Horror Musical Mystery Romance Sci-Fi Short Sport Thriller
      War Western
    )
    categories.each { |c| Category.create title: c }
  end
end
