# collects events (Github Commits, Gcal Meetings)
# saves them to redis to be emailed later
class DataCollector
  include Sidekiq::Worker
  sidekiq_options retry: 1, queue: :critical

  def perform(user_id)
    @user = User.find(user_id)
    save_events(collect_events)
  end

  def save_events(events)
    key = "#{Date.today}-#{@user.id}-#{integration_name}"
    $redis.set(key, events.to_json)
  end

  def collect_events
    raise 'Must override collect_events'
  end

  def integration_name
    raise 'Must override integration name'
  end

  def current_user_time
    Time.now.in_time_zone(@user.time_zone)
  end
end