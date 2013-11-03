# schedules when users data should be collected
# based on their timezone
class Scheduler
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly }

  def perform
  end
end