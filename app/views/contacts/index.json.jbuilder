json.array!(@contacts) do |contact|
  json.extract! contact, :id, :user_id, :name, :surname, :email, :picture, :type_of_contact
  json.url contact_url(contact, format: :json)
end
