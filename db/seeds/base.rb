load 'db/seeds/yaml_seed_loading.rb'
load 'db/seeds/user.rb'
load 'db/seeds/category.rb'
load 'db/seeds/movie.rb'

module Seeds
  class Base
    def self.run!
      reset_column_information

      Seeds::User.seed_all
      Seeds::Category.seed_all
      Seeds::Movie.seed_all
    end

    def self.reset_column_information
      ActiveRecord::Base.send(:subclasses).each { |klass| klass.reset_column_information rescue nil }
    end
  end
end
