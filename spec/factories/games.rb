FactoryGirl.define do
  factory :game do |f|
    f.id 1
    f.schedule Time.now
    f.description "Game test"
    f.for_betting true
  end
end
