require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'Accessing Homepage' do
  	context 'when authenticated' do
  	  before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user)
        sign_in user
      end

      it 'returns http success when user is logged in' do
        get :index
        expect(response).to have_http_status(:success)
      end
  	end

  	context 'when not authenticated' do
  	  it 'it redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
  	end
  end
end
