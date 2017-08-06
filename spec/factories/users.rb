FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "name#{n}@gmail.com"
    end
    password "102410241024"
  end
end
