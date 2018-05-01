class ContactsController < ApplicationController

  def new
      @contact = Contact.new
  end

  def sub_create
    @contact = Contact.new(contacts_params)
    if @contact.valid?
      render 'confirm'
    else
      render 'new'
    end
  end

  def confirm
    if params[:contact].blank?
      redirect_to new_contact_path
    else
      @contact = Contact.new(contacts_params)
    end
  end

  def create
    @contact = Contact.new(contacts_params)
    if params[:back]
      render 'new'
    elsif @contact.save
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
