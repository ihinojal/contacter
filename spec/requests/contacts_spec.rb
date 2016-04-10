require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  let(:contact){FactoryGirl.create(:contact)}
  describe "GET /contacts" do
    it "works! (now write some real specs)" do
      get user_contacts_path(contact.user)
      expect(response).to have_http_status(200)
    end
  end
end
