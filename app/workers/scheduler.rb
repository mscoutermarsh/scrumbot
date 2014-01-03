# schedules when users data should be collected
# based on their timezone
class Scheduler
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: 1, queue: :critical

  recurrence { hourly }

  def perform
    users = User.active.includes(:integrations).where('time_zone in (?)', midnight_zones)

    users.each do |user|
      unless user.integrations.empty?
        schedule_github(user)
        schedule_email(user)
      end
    end
  end

  def schedule_github(user)
    GithubCollector.perform_in(random_hour, user.id) if user.integrations.github
  end

  def schedule_email(user)
    DailyEmail.perform_in(8.5.hours, user.id)
  end

  def random_hour
    # balance out jobs in case of API rate limiting
    rand(8).hours
  end

  def midnight_zones
    time_zones.all.select{|tz| Time.now.in_time_zone(tz).hour == 0 }
  end

  def time_zones
    time_zones = ActiveSupport::TimeZone.zones_map.values.collect{|z| z.name }
  end

end