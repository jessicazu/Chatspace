require 'faker'
FactoryGirl.define do

  factory :group do
    name          {Faker::Lorem.words}
  end
end
