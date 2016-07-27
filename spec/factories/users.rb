FactoryGirl.define do
  factory :confirmed_user, class: 'User' do |f|
    f.first_name 'Juan'
    f.last_name 'Dele Cruz'
    f.contact_number '09191234567'
    f.email 'me@nowhere.com'
    f.password 'abcd1234'
    f.confirmed_at Time.now
  end

  factory :confirmed_admin, class: 'User' do |f|
    f.first_name 'Juan'
    f.last_name 'Dele Cruz'
    f.contact_number '09191234567'
    f.email 'me@nowhere.com'
    f.password 'abcd1234'
    f.confirmed_at Time.now
    f.admin true
  end

  factory :unconfirmed_user, class: 'User' do |f|
    f.first_name 'Juan'
    f.last_name 'Dele Cruz'
    f.contact_number '09191234567'
    f.email 'me@nowhere.com'
    f.password 'abcd1234'
  end
end
