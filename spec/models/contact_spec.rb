require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:user){ FactoryGirl.create(:user) }
  describe 'Un contacto' do
    let(:contact){ FactoryGirl.create(:contact) }
    let(:contact_with_picture) do 
      FactoryGirl.create(:contact_with_picture)
    end
    it 'puede ser creado' do
      expect{ contact }.to change{ Contact.count }.by(1)
    end
    describe 'cuando es generado por las factories' do
      it 'por defecto es valido' do
        expect( contact ).to be_valid
      end
    end
    describe 'con el atributo' do
      describe 'usuario' do
        it 'sin estar presente, no sera valido' do
          expect( FactoryGirl.build(:contact, user: nil))
            .not_to be_valid
        end
      end
      describe 'name' do
        it 'sin estar presente, no sera valido' do
          expect( FactoryGirl.build(:contact, name: nil))
            .not_to be_valid
        end
      end
      describe 'surname' do
        it 'sin estar presente, no sera valido' do
          expect( FactoryGirl.build(:contact, surname: nil))
            .not_to be_valid
        end
      end
      describe 'type_of_contact' do
        it 'pueden ser listados' do
          expect( Contact::CONTACT_TYPES ).to be_a(Array)
        end
        it 'puede ser de tipo familia' do
          expect( FactoryGirl.build(:contact, type_of_contact: 'family'))
            .to be_valid
        end
        it 'puede ser de tipo amigo' do
          expect( FactoryGirl.build(:contact, type_of_contact: 'friend'))
            .to be_valid
        end
        it 'puede ser de tipo compañero' do
          expect( FactoryGirl.build(:contact, type_of_contact: 'coworker'))
            .to be_valid
        end
        it 'no puede ser de otro tipo' do
          expect{ FactoryGirl.build(:contact, type_of_contact: 'mascota')}
            .to raise_exception(ArgumentError)
        end
        it 'no puede no indicarse' do
          expect( FactoryGirl.build(:contact, type_of_contact: nil))
            .not_to be_valid
        end
        
      end
      describe 'picture' do
        context 'estando presente' do
          it 'sera valido igualmente' do
            expect( contact_with_picture ).to be_valid
          end
          it 'se puede recuperar la url de la imagen' do
            expect( contact_with_picture.picture.to_s )
              .to include('.png')
          end
        end
        context 'no presente' do
          it 'sera valido igualmente' do
            expect( contact ).to be_valid
          end
        end
      end
      describe 'email' do
        it 'sin estar presente, no sera valido' do
          expect( FactoryGirl.build(:contact, email: nil))
            .not_to be_valid
        end
        it 'debe tener un formato adecuado' do
          expect( FactoryGirl.build(:contact, email: 'notvalidemail@'))
            .not_to be_valid
        end
        describe 'si ya esta en la base de datos,' do
          it 'no podrá estar duplicado en la agenda de usuario' do
            expect( FactoryGirl.build(:contact, 
                                email: contact.email,
                                user: contact.user )
            ).not_to be_valid
          end
          it 'si podra estar duplicado en otra agenda' do
            # Agregar contacto a usuario
            contact
            expect( FactoryGirl.build(:contact, 
                                email: contact.email)
            ).to be_valid
          end
        end
      end
    end
  end
end
