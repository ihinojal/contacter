require 'rails_helper'

RSpec.describe "contacts/edit", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :user => nil,
      :name => "MyString",
      :surname => "MyString",
      :email => "MyString",
      :picture => "",
      :type_of_contact => 1
    ))
  end

  it "renders the edit contact form" do
    render

    assert_select "form[action=?][method=?]", contact_path(@contact), "post" do

      assert_select "input#contact_user_id[name=?]", "contact[user_id]"

      assert_select "input#contact_name[name=?]", "contact[name]"

      assert_select "input#contact_surname[name=?]", "contact[surname]"

      assert_select "input#contact_email[name=?]", "contact[email]"

      assert_select "input#contact_picture[name=?]", "contact[picture]"

      assert_select "input#contact_type_of_contact[name=?]", "contact[type_of_contact]"
    end
  end
end
