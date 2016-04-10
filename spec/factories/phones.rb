FactoryGirl.define do
  factory :phone do
    sequence(:number)  { |n| "91 555 55 #{n}" }
    association       :contact
  end
end
