class Seeds::Movie
  extend ::YamlSeedLoading

  def self.seed_all
    movie_attributes.each do |attributes|
      unless ::Movie.exists?(title: attributes['title'])
        movie = ::Movie.new(attributes.except('categories'))
        attributes['categories'].to_a.each do |category|
          begin
            movie.categories << ::Category.find_by(title: category)
          rescue Exception => ex
            p ex
            p category
          end
        end
        movie.save(validate: false)
      end
    end
  end

  protected

  def self.movie_attributes
    @movie_attributes ||= yaml_seed('movies')
  end
end
