class ContactsController < ApplicationController
  def show
  end

  def create
    ContactMailer.with(
      name: params[:name],
      email: params[:email],
      subject: params[:subject],
      message: params[:message]
    ).contact_email.deliver_now
    redirect_to contact_url, notice: 'Viestisi lähetettiin onnistuneesti!'
  end
end
