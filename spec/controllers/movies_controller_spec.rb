require 'rails_helper'

shared_context :build_movies_with_categories_ratings do
  let!(:category1) { create(:category_with_movies) }
  let!(:category2) { create(:category_with_movies, movies_count: 2) }
  let!(:movie1) { create(:movie, :with_rating) }
  let!(:movie2) { create(:movie, :with_rating, rating: 4) }
  let!(:movie3) { create(:movie, :with_rating, rating: 4) }
end

RSpec.describe MoviesController, type: :controller do
  let(:user) { create(:user) }

  describe 'before actions' do
    it { is_expected.to use_before_action(:load_categories) }
    it { is_expected.to use_before_action(:set_movie) }
    it { is_expected.to use_before_action(:authenticate_user!) }
  end

  describe "GET index" do
    context 'response object' do
      it 'returns success response' do
        get :index
        expect(response).to have_http_status(200)
      end
      it 'renders index page with movies' do
        get :index
        expect(response).to render_template :index
      end
    end

    context 'assigns instance variables' do
      let(:movie) { create(:movie) }
      it "assigns @movies" do
        get :index
        expect(assigns(:movies)).to be_kind_of(ActiveRecord::Relation)
        expect(assigns(:movies)).to match_array([movie])
      end
      it 'assigns @categories' do
        #TODO
      end
    end

    context 'with params' do
      include_context :build_movies_with_categories_ratings

      it 'returns list of all movies if no params passed' do
        get :index
        expect(assigns(:movies).count).to eq(8)
        expect(assigns(:movies)).to match_array(Movie.all)
      end

      it 'returns movie list filtered by category' do
        get :index, params: { category: category1 }
        expect(assigns(:movies).count).to eq(3)
        expect(assigns(:movies)).to match_array(category1.movies)
      end

      it 'returns movie list filtered by rating' do
        get :index, params: { rating: 4}
        expect(assigns(:movies).count).to eq(2)
        expect(assigns(:movies)).to match_array([movie2, movie3])
      end

      it 'sorts the movie list by average rating in DESC order' do
        get :index
        expect(assigns(:movies).first).to eq(movie2)
      end
    end

    context 'facet filters' do
      include_context :build_movies_with_categories_ratings

      it 'assigns @category_groups' do
        get :index
        expect(assigns(:category_groups)).not_to be_empty
      end

      it 'builds category groups by movie_count' do
        get :index
        expect(assigns(:category_groups).count).to eq(2)
        expect(assigns(:category_groups)).to include({category1 => 3}, {category2 => 2})
      end

      it 'assigns @rating_groups' do
        get :index
        expect(assigns(:rating_groups)).not_to be_empty
      end

      it 'builds rating groups by movie_count' do
        get :index
        expect(assigns(:rating_groups).count).to eq(6)
        expect(assigns(:rating_groups)).to include({ 5 => 0, 4 => 2, 3 => 0, 2 => 0, 1 => 1, nil => 5})
      end
    end

    context 'search' do
      let!(:movie1) { create(:movie, title: 'Avengers') }
      let!(:movie2) { create(:movie, title: 'Avengers Endgame') }
      it 'filters movies for searched title' do
        Movie.__elasticsearch__.refresh_index!
        get :index, params: { q: 'Avengers' }
        expect(assigns(:movies).count).to eq(2)
      end
      it 'returns no records if searched title not found' do
        Movie.__elasticsearch__.refresh_index!
        get :index, params: { q: 'Captain America' }
        expect(assigns(:movies).count).to eq(0)
      end
    end

    context 'pagination' do
      before(:all) do
        # Temporarily reduce the limit of movies per page to avoid having to
        # create a large number of records.
        @original_max_per_page = Kaminari.config.default_per_page
        Kaminari.config.default_per_page = 2
      end
      after(:all) do
        # Restore original pagination settings
        Kaminari.config.default_per_page = @original_max_per_page
      end
      let!(:category) { create(:category_with_movies) }

      it 'returns first page by default' do
        get :index
        expect(assigns(:movies).count).to eq(2)
      end
      it 'returns records for specified page' do
        get :index, params: { page: 2 }
        expect(assigns(:movies).count).to eq(1)
      end
    end
  end

  describe 'GET new' do
    subject { get :new }
    it_behaves_like :authenticate_user_and_force_login

    context 'if user signed in' do
      before(:each) { sign_in user }
      context 'response object' do
        it 'returns success response and renders new movie form' do
          is_expected.to have_http_status(200)
          is_expected.to render_template :new
        end
        it 'assigns movie as new instance variable' do
          subject
          expect(assigns[:movie]).to be_instance_of(Movie)
        end
      end
    end
  end

  describe 'POST create' do
    subject { post :create, params: params }
    let(:params) { { movie: { title: 'Cast Away' } } }

    it_behaves_like :authenticate_user_and_force_login

    context 'if user signed in' do
      before(:each) { sign_in user }
      context 'when params are valid' do
        it 'creates new movie successfully' do
          subject
          expect(assigns(:movie)).to be_instance_of(Movie)
          expect(assigns(:movie).title).to eq('Cast Away')
        end
        it 'redirects to movies path' do
          is_expected.to redirect_to movies_path
        end
        it 'is expected to set flash message' do
          subject
          expect(flash[:notice]).to eq('Movie was successfully created')
        end
      end

      context 'when params are not valid' do
        let(:params) { { movie: { title: '' } } }
        it 'raises an error and render new movie form again' do
          is_expected.to render_template(:new)
        end
        it 'adds errors to title attribute' do
          subject
          expect(assigns(:movie).errors[:title]).to eq(['can\'t be blank'])
        end
      end
    end
  end

  describe 'GET edit' do
    subject { get :edit, params: params }
    let(:movie) { create(:movie, user: user) }
    let(:params) { { id: movie.id } }

    it_behaves_like :authenticate_user_and_force_login

    context 'if user signed in' do
      before(:each) { sign_in user }

      context 'response object' do
        it 'returns success response and renders edit movie form' do
          is_expected.to have_http_status(200)
          is_expected.to render_template :edit
        end
        it 'assigns movie to instance variable' do
          subject
          expect(assigns(:movie)).to be_instance_of(Movie)
          expect(assigns(:movie)).to eq(movie)
        end
      end
    end
  end

  describe 'PATCH update' do
    subject { patch :update, params: params }
    let(:movie) { create(:movie, user: user) }
    let(:params) { { id: movie.id } }

    it_behaves_like :authenticate_user_and_force_login

    context 'if user signed in' do
      before(:each) { sign_in user }
      context 'when params are valid' do
        let(:params) { { id: movie.id, movie: { title: 'Updated title' } } }
        it 'updates movie details successfully' do
          subject
          expect(assigns(:movie).persisted?).to be_truthy
          expect(assigns(:movie).title).to eq('Updated title')
        end
        it 'redirects to movies path' do
          is_expected.to redirect_to movies_path
        end
        it 'is expected to set flash message' do
          subject
          expect(flash[:notice]).to eq('Movie was successfully updated')
        end
      end

      context 'when params are not valid' do
        let(:params) { { id: movie.id, movie: { title: '' } } }
        it 'raises an error and render edit movie form again' do
          is_expected.to render_template(:edit)
        end
        it 'adds errors to title attribute' do
          subject
          expect(assigns(:movie).errors[:title]).to eq(['can\'t be blank'])
        end
      end
    end
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, params: params }
    let(:movie) { create(:movie, user: user) }
    let(:params) { { id: movie.id } }

    it_behaves_like :authenticate_user_and_force_login

    context 'if user signed in' do
      before(:each) { sign_in user }

      context 'response object' do
        it 'returns success response and renders edit movie form' do
          is_expected.to have_http_status(302)
          is_expected.to redirect_to movies_path
        end
        it 'deletes movie record' do
          subject
          expect(Movie.count).to eq(0)
          expect(assigns(:movie).persisted?).to be_falsey
        end
      end
    end
  end
end
