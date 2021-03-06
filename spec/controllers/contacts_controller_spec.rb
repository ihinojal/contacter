require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ContactsController, type: :controller do
  let(:contact){ FactoryGirl.create(:contact) }
  let(:user){ FactoryGirl.create(:user) }
  let(:another_user){ FactoryGirl.create(:user) }

  describe "GET #index" do
    it "asigna todos los contactos a @contacts" do
      get :index, {user_id: contact.user}
      expect(assigns(:contacts)).to include(contact)
    end
    it 'no incluye los contactos de otros usuarios' do
      get :index, {user_id: another_user}
      expect(assigns(:contacts)).not_to include(contact)
    end
    describe 'buscar contacto por nombre' do
      context 'existente' do
        it 'es encontrado' do
          get :index, {user_id: contact.user, search: contact.name}
          expect(assigns(:contacts).length).to eq(1)
        end
      end
      context 'inexistente' do
        it 'no es encontrado' do
          get :index, {user_id: contact.user, search: 'nombreindexistente'}
          expect(assigns(:contacts).length).to eq(0)
        end
      end
    end
    describe 'buscar contacto por apellido' do
      context 'existente' do
        it 'es encontrado' do
          get :index, {user_id: contact.user, search: contact.surname}
          expect(assigns(:contacts).length).to eq(1)
        end
      end
      context 'inexistente' do
        it 'es encontrado' do
          get :index, {user_id: contact.user, search: 'apellidoindexistente'}
          expect(assigns(:contacts).length).to eq(0)
        end
      end
    end
  end

  describe "GET #show" do
    it "asigna el contacto pedido a @contact" do
      get :show, {id: contact.to_param}
      expect(assigns(:contact)).to eq(contact)
    end
  end

  describe "GET #new" do
    context 'si no esta logeado' do
      it 'redirigir a iniciar sesión' do
        get :new, {user_id: user}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'si esta logeado' do
      before(:each){sign_in user}
      it "assigns a new contact as @contact" do
        get :new, {user_id: user.to_param }
        expect(assigns(:contact)).to be_a_new(Contact)
      end
    end
  end

  describe "GET #edit" do
    describe 'si no esta logeado' do
      it 'redirigir a iniciar sesión' do
        get :edit, {id: contact.to_param}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'si esta logeado' do
      before(:each){sign_in contact.user}
      it "assigns the requested contact as @contact" do
        get :edit, {id: contact.to_param}
        expect(assigns(:contact)).to eq(contact)
      end
    end
  end

  describe "POST #create" do
    describe 'si no esta logeado' do
      it 'redirigir a iniciar sesión' do
        post :create, {user_id: user, contact: FactoryGirl.attributes_for(:contact) }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'si esta logeado' do
      before(:each){sign_in user}
      context "con parametros válidos" do
        it "crea un nuevo contacto" do
          expect {
            post :create, {user_id: user, contact: FactoryGirl.attributes_for(:contact) }
          }.to change(Contact, :count).by(1)
        end

        it "asigna un nuevo contacto a @contact" do
          post :create, {user_id: user, contact: FactoryGirl.attributes_for(:contact) }
          expect(assigns(:contact)).to be_a(Contact)
          expect(assigns(:contact)).to be_persisted
        end

        it "redirige a página de contacto creado" do
          post :create, {user_id: user, contact: FactoryGirl.attributes_for(:contact) }
          expect(response).to redirect_to(Contact.last)
        end
      end

      context "con parametros inválidos" do
        before :each do
          allow_any_instance_of(Contact).to receive(:save)
            .and_return(false)
        end
        it "asigna un nuevo contacto (sin crear) como @contact" do
          post :create, {user_id: user, contact: FactoryGirl.attributes_for(:contact) }
          expect(assigns(:contact)).to be_a_new(Contact)
        end

        it "re-renders la plantilla 'new'" do
          post :create, {user_id: user, contact: FactoryGirl.attributes_for(:contact) }
          expect(response).to render_template("new")
        end
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes){ {name: 'Fulano'} }
    describe 'si no esta logeado' do
      it 'redirigir a iniciar sesión' do
        put :update, {id: contact.to_param,
                       contact: FactoryGirl.attributes_for(:contact) }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'si esta logeado pero NO como dueño del contact' do
      before(:each){sign_in another_user}
      it 'no lo puede actualizar' do
        expect{
          put :update, {id: contact.to_param, contact: new_attributes}
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
    context 'si esta logeado como dueño del contact' do
      before(:each){sign_in contact.user}
      context "with valid params" do

        it "actualiza el contacto" do
          put :update, {id: contact.to_param, contact: new_attributes}
          contact.reload
          expect( contact.name).to eq(new_attributes[:name])
        end

        it "asigna contacto actualizado a @contact" do
          put :update, {id: contact.to_param, contact: new_attributes}
          expect(assigns(:contact)).to eq(contact)
        end

        it "redirige a pagina de contacto" do
          put :update, {id: contact.to_param, contact: new_attributes}
          expect(response).to redirect_to(contact)
        end
      end

      context "con parametros inválidos" do
        before :each do
          allow_any_instance_of(Contact).to receive(:update)
            .and_return(false)
        end
        it "asigna el contacto a @contact" do
          put :update, {id: contact.to_param, contact: new_attributes}
          expect(assigns(:contact)).to eq(contact)
        end

        it "re-renders la plantilla 'edit'" do
          put :update, {id: contact.to_param, contact: new_attributes}
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "DELETE #destroy" do
    describe 'si no esta logeado' do
      it 'redirigir a iniciar sesión' do
        delete :destroy, {id: contact.to_param}
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'si esta logeado pero NO es dueño del contact' do
      before(:each){sign_in another_user}
      it 'no lo puede destruir' do
        expect{
          delete :destroy, {id: contact.to_param}
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
    context 'si esta logeado y es dueño del contact' do
      before(:each){sign_in contact.user}
      it "elimina el contacto" do
        expect {
          delete :destroy, {id: contact.to_param}
        }.to change(Contact, :count).by(-1)
      end

      it "redirige al listado de contactos de este usuario" do
        delete :destroy, {id: contact.to_param}
        expect(response).to redirect_to(user_contacts_path(contact.user))
      end
    end
  end

end
