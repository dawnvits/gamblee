require 'rails_helper'

RSpec.describe User, type: :model do
  let(:incomplete_user_info) { build(:incomplete_user_info) }
  let(:user) { build(:user) }

  context 'registration' do
    it 'with a missing field' do
      expect(incomplete_user_info.save).to eq(false)
    end

    it 'with no missing field' do
      expect(user.save).to eq(true)
    end
  end
end
