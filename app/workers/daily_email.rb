# renders and sends out daily email to user
class DailyEmail
  include Sidekiq::Worker
  sidekiq_options retry: 1, queue: :email

  def perform(user_id)
    MorningMailer.delay.scrum_update(user_id)
  end

end