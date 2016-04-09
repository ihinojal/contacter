require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Un usuario' do
    let(:user){ FactoryGirl.create(:user) }
    xit 'puede tener multiples contactos' do
      expect( User.contacts.build ).to be_a( Contact )
    end
    describe 'cuando es generado por las factories' do
      it 'por defecto es valido' do
        expect( user ).to be_valid
      end
    end
    it 'puede ser creado' do
      expect{ user }.to change{User.count}.by(1)
    end
  end
end
