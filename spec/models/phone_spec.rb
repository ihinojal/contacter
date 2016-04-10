require 'rails_helper'

RSpec.describe Phone, type: :model do
  describe 'Un telefono' do
    describe 'con attributo' do
      describe 'contact' do
        it 'si no esta presente no es valido' do
          expect( FactoryGirl.build(:phone, contact: nil))
          .not_to be_valid
        end
      end
      describe 'number' do
        it 'si no esta presente no es valido' do
          expect( FactoryGirl.build(:phone, number: nil))
          .not_to be_valid
        end
      end
    end
  end
end
