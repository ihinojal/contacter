require 'rails_helper'

RSpec.describe "layouts/_header.slim", type: :view do
  let(:user){FactoryGirl.create(:user)}
  context 'si usuario no ha iniciado sesion' do
    before(:each){render}
    it 'aparece link de "Iniciar sesión"' do
      expect(rendered)
      .to have_selector('[href="/users/sign_in"]')
    end
    it 'aparece link de "Registrarse"' do
      expect(rendered)
      .to have_selector('[href="/users/sign_up"]')
    end
  end
  context 'si usuario ha iniciado sesion' do
    before(:each) do
      sign_in user
      render
    end
    it 'aparece link de "Cerrar sesión"' do
      expect(rendered)
      .to have_selector('[href="/users/sign_out"]')
    end
  end
end
