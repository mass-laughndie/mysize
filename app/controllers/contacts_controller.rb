class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def sub_create
    @contact = Contact.new(contacts_params)
    render 'confirm' and return if @contact.valid?
    render 'new'
  end

  def confirm
    redirect_to new_contact_path and return if params[:contact].blank?
    @contact = Contact.new(contacts_params)
  end

  def create
    @contact = Contact.new(contacts_params)
    render 'new' and return if params[:back]

    if @contact.save
      @contact.send_email(:received_message)
      redirect_to thanks_contact_path
    else
      flash.now[:danger] = "送信できませんでした。<br>通信環境などをご確認ください。"
      render 'new'
    end
  end

  def thanks
  end

  private

  def contacts_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
