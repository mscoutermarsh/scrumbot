Sidekiq::Extensions::DelayedMailer.class_eval do
  sidekiq_options :retry => 1
end