class ContactsController < ApplicationController
  
  # GET request to /contact-us
  # show new contact form
  
  def new
    @contact = Contact.new
  end
  
  # POST request to /contacts
  
  def create
    # mass assignments of form fields into Contact Objects
    @contact = Contact.new(contact_params)
    # save Contact Objects to the db
    if @contact.save
      # store form fields via parameters into variables
      name = params[:contact][:name]
      email = params [:contact][:name]
      body = params [:contact][:comments]
      ContactMailer.contact_email(name, email, body).deliver
       flash[:success] = "Message sent." 
       redirect_to new_contact_path
    else
      flash[:danger] = @contact.errors.full_messages.join(", ")
       redirect_to new_contact_path
    end
  end
  private
  # to collect data from the forms we need to use
  # strong parameters and whitelist the form fields
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
    
end