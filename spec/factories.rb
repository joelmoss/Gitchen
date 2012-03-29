FactoryGirl.define do

  factory :user do
    username Faker::Internet.user_name
    github_access_token 'somerandomstring'
  end

end
