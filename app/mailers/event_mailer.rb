class EventMailer < ApplicationMailer
  def upcoming_events
    @events = Event.upcoming_events
    mail(to: 'jonivainiokaila@gmail.com', subject: 'Yleisurheilutiedotteet')
  end
end
