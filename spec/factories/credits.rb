FactoryGirl.define do
  factory :credit_worth_100, class: 'Credit' do |f|
    f.free_credit 10
    f.purchased_credit 90
    f.total_credit 100
  end
end
