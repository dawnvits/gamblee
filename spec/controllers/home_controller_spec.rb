require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
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
end
