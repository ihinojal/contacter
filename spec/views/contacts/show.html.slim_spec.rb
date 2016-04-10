require 'rails_helper'

RSpec.describe "contacts/show", type: :view do
  before(:each) do
    @contact = assign(:contact, Contact.create!(
      :user => nil,
      :name => "Name",
      :surname => "Surname",
      :email => "Email",
      :picture => "",
      :type_of_contact => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Surname/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
  end
end
