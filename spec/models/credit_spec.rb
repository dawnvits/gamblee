require 'rails_helper'

RSpec.describe Credit, type: :model do
  it { belong_to(:user) }
end
