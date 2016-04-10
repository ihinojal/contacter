require 'rails_helper'

RSpec.describe "contacts/new", type: :view do
  let(:contact){FactoryGirl.build(:contact)}
  before(:each){ assign(:contact, contact) }

  it "renders el formulario de contacto" do
    render

    assert_select "form[action=?][method=?]", contacts_path, "post" do
      assert_select "input#contact_name[name=?]", "contact[name]"
      assert_select "input#contact_surname[name=?]", "contact[surname]"
      assert_select "input#contact_email[name=?]", "contact[email]"
      assert_select "input#contact_picture[name=?]", "contact[picture]"
      assert_select "input#contact_type_of_contact[name=?]", "contact[type_of_contact]"
    end
  end
end
