desc 'Send whatsapp info of upcoming events'
task :send_whatsapp_info => :environment do
  unless Date.today.wday == 1
    abort('Whastapp info can be sent only on mondays')
  end

  phone = Rails.application.credentials.dig(:call_me_bot, :phone)
  apikey = Rails.application.credentials.dig(:call_me_bot, :apikey)
  events = Event.upcoming_events

  HTTP.get("https://api.callmebot.com/whatsapp.php",
    params: {
      phone: phone,
      apikey: apikey,
      text: '*Tulevat Tapahtumat*'
    }
  )

  events.each do |event|
    text = ApplicationController.render(template: 'events/whatsapp/event', layout: nil, assigns: { event: event })
    HTTP.get("https://api.callmebot.com/whatsapp.php",
      params: {
        phone: phone,
        apikey: apikey,
        text: text
      }
    )
  end

  HTTP.get("https://api.callmebot.com/whatsapp.php",
    params: {
      phone: phone,
      apikey: apikey,
      text: 'Kaikki tapahtumat löydät osoitteesta%0Awww.laitilanjyskeyleisurheilu.fi/tapahtumat'
    }
  )
end
