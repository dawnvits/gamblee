require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should validate_presence_of(:betting_time) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:schedule) }
end
