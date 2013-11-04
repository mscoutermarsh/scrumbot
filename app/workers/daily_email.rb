# renders and sends out daily email to user
class DailyEmail
  include Sidekiq::Worker
  sidekiq_options retry: 1, queue: :email

  def perform
  end

end