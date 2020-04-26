require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:categories) }
    it { is_expected.to have_many(:ratings) }
    it { is_expected.to belong_to(:user).optional(true) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
  end

  context 'in category' do
    let(:category) { create(:category_with_movies) }
    let(:movie) { create(:movie) }

    it 'returns list of movies in category' do
      expect(Movie.in_category(category.id)).to match_array(category.movies)
    end

    it 'does not return movie not belonging to category' do
      expect(Movie.in_category(category.id)).not_to include(movie)
    end
  end

  context 'average_rating' do
    let(:movie) { create(:movie, :with_rating, rating: 5) }

    it 'returns average rating for movie' do
      create(:rating, movie: movie, rating: 3)
      expect(movie.average_rating).to eql(4.0)

      create(:rating, movie: movie, rating: 1)
      expect(movie.average_rating).to eql(3.0)
    end
  end
end
