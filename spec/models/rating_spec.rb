require 'rails_helper'

RSpec.describe Rating, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:movie) }
  end

  context 'validations' do
    it { is_expected.to validate_uniqueness_of(:movie_id).scoped_to(:user_id) }
  end

  context 'average_rating' do
    let(:movie) { create(:movie, :with_rating, rating: 5) }

    it 'triggers recalculation of average rating of movie' do
      create(:rating, movie: movie, rating: 3)
      expect(movie.average_rating).to eql(4.0)

      create(:rating, movie: movie, rating: 1)
      expect(movie.average_rating).to eql(3.0)
    end
  end
end
