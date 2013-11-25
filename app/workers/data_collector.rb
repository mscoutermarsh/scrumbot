# collects events (Github Commits, Gcal Meetings)
# saves them to redis to be emailed later
class DataCollector
  include Sidekiq::Worker
  sidekiq_options retry: 1, queue: :critical

  def perform(user_id)
    @user = User.find(user_id)
    events = collect_events
    save_events(events) unless events.empty?
  end

  def save_events(events)
    integration.todays_events = events.to_json
  end

  def collect_events
    raise 'Must override collect_events'
  end

  def integration
    raise 'Must override integration'
  end
end