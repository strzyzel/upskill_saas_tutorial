class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      name = params[:contact][:name]
      email = params [:contact][:name]
      body = params [:contact][:comments]
      ContactMailer.contact_email(name, email, body).deliver
       redirect_to new_contact_path, notice: "Message sent."
    else
       redirect_to new_contact_path, notice: "Error occured."
    end
  end
  private
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
    
end