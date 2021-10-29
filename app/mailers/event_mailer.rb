class EventMailer < ApplicationMailer
  def upcoming_events
    @events = Event.upcoming_events(1)
    mail(to: 'jonivainiokaila@gmail.com', subject: 'Yleisurheilutiedotteet')
  end
end
