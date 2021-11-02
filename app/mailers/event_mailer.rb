class EventMailer < ApplicationMailer
  def upcoming_events
    @events = Event.upcoming_events(1)
    mail(to: 'ilmoitukset@laitilansanomat.fi', bcc: ['laitilan.jyske@lailanet.fi'], subject: 'Yleisurheilutiedotteet')
  end
end
