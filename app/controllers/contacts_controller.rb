class ContactsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  # GET /users/:user_id/contacts(.:format)
  def index
    @contacts = Contact.where(user_id: params[:user_id])
  end

  # GET /contacts/:id(.:format)
  def show
    @contact = Contact.find(params[:id])
  end

  # GET /contacts/new(.:format)
  def new
    @contact = Contact.new
  end

  # GET /contacts/:id/edit(.:format)
  def edit
    @contact = Contact.find( params[:id] )
  end

  # POST /contacts(.:format)
  def create

    @contact = current_user.contacts.build(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: t('.success')}
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts(.:format)
  def update
    @contact = current_user.contacts.find(params[:id])
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: t('.success')}
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to user_contacts_path(current_user), notice: t('.success')}
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:user_id, :name, :surname, :email,
                                      :picture, :type_of_contact)
    end
end
