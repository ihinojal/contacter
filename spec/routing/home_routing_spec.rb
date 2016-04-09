require 'rails_helper'

RSpec.describe "En controlador home", type: :routing do
  it "Pagina raiz '/' redirige a #welcome" do
    expect(get: "/").to route_to( controller: "home", action: "welcome")
  end
end
