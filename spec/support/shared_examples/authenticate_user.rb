shared_examples :authenticate_user_and_force_login do
  context 'if user not signed in' do
    it 'halts operation and redirects to user sign in page' do
      is_expected.to have_http_status(302)
      is_expected.to redirect_to new_user_session_path
    end
  end
end
