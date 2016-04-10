require 'rails_helper'

RSpec.describe "contacts/index", type: :view do
  before(:each) do
    assign(:contacts, [
      Contact.create!(
        :user => nil,
        :name => "Name",
        :surname => "Surname",
        :email => "Email",
        :picture => "",
        :type_of_contact => 1
      ),
      Contact.create!(
        :user => nil,
        :name => "Name",
        :surname => "Surname",
        :email => "Email",
        :picture => "",
        :type_of_contact => 1
      )
    ])
  end

  it "renders a list of contacts" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Surname".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
