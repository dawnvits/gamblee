FactoryGirl.define do
  factory :user, class: 'User' do |f|
    f.first_name 'abcd1234'
    f.last_name 'abcd1234'
    f.contact_number '09197766345'
    f.email 'me@nowhere.com'
    f.password 'abcd1234'
  end
  
  factory :incomplete_user_info, class: 'User' do |f|
  	f.first_name 'abcd1234'
  	f.last_name 'abcd1234'
  	f.email 'me@nowhere.com'
  end
end
