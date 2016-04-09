FactoryGirl.define do
  factory :user do
    sequence(:email)        { |n| "person#{n}@example.com" }
    password                "password"
    password_confirmation   "password"
    # Una vez ha sido generado el usuario por la factory, confirmar
    # automaticamente.
    #after(:build)           { |user| user.confirm  }
  end
end
