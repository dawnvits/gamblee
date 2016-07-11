FactoryGirl.define do
  factory :user, class: 'User' do |f|
    f.first_name 'Juan'
    f.last_name 'Dele Cruz'
    f.contact_number '09191234567'
    f.email 'me@nowhere.com'
    f.password 'abcd1234'
  end
  
  factory :incomplete_user_info, class: 'User' do |f|
  	f.first_name 'Juan'
  	f.last_name 'Dela Cruz'
  	f.email 'me@nowhere.com'
  end
end
