desc "Send email info to local newspaper"
task :send_email_info => :environment do
  unless [1, 4].include?(Date.today.wday)
    abort('Email can be send only on mondays and thurdays') 
  end
  EventMailer.upcoming_events.deliver_now
end
