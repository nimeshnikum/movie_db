require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let(:user) { create(:user) }
  let(:movie) { create(:movie, user: user) }

  describe 'POST create' do
    subject { post :create, params: params }
    let(:params) { { movie_id: movie.id, rating: 5 } }

    it_behaves_like :authenticate_user_and_force_login

    context 'if user signed in' do
      before(:each) { sign_in user }

      context 'response' do
        it 'responds with 200 code and renders partial' do
          is_expected.to have_http_status(200)
          is_expected.to render_template 'movies/_movie_row'
        end
      end

      context 'when rating exists' do
        let!(:rating) { create(:rating, movie: movie, user: user, rating: 3) }

        it 'does not create new rating' do
          expect { subject }.not_to change { Rating.count }
        end

        it 'updates rating' do
          expect { subject }.to change { rating.reload.rating }.from(3).to(5)
        end
      end

      context 'when rating does not exist' do
        it 'does not create new rating' do
          expect { subject }.to change { Rating.count }.by(1)
        end

        it 'creates rating record with selected rating' do
          subject
          expect(Rating.last.rating).to eq(5)
        end
      end
    end
  end
end
