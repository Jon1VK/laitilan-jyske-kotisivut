class ContactMailer < ApplicationMailer
  def contact_email
    @name = params[:name]
    @subject = params[:subject]
    @message = params[:message]
    mail(to: params[:email], bcc: ['laitilan.jyske@lailanet.fi'], subject: "Kiitos yhteydenotosta, viestisi on vastaanotettu!")
  end
end
