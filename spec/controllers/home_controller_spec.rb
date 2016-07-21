require 'rails_helper'
require 'support/devise'

RSpec.describe HomeController, type: :controller do
  describe 'Accessing Homepage as confirmed user' do
  	context 'when authenticated' do
  	  before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:confirmed_user)
        sign_in user
      end

      it 'permits access' do
        get :index
        expect(response).to have_http_status(:success)
      end
  	end

  	context 'when not authenticated' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
  	end
  end
end
