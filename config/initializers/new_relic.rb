if defined? Unicorn and !Rails.env.test?
  ::NewRelic::Agent.manual_start()
  ::NewRelic::Agent.after_fork(force_reconnect: true)
end
