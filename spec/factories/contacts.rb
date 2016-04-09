FactoryGirl.define do
  factory :contact do
    association       :user
    name              { ['Pepe','Juan','Pedro'].sample }
    surname           { ['Sanchez','Rodriguez'].sample }
    sequence(:email)  { |n| "contact#{n}@example.com" }
    type_of_contact   { Contact::CONTACT_TYPES.sample }

    factory :contact_with_picture do
      picture do
        file = Rails.root.join('spec', 'fixtures', "user_picture.png")
        fixture_file_upload( file, 'image/jpeg')
      end
    end
  end
end
