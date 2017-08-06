FactoryGirl.define do
  factory :wallet do
    sequence :balance do |n|
      n.to_i
    end
  end
end
