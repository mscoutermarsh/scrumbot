class DailyMailer < ActionMailer::Base
  default from: "goodmorning@scrumlogs.com"

  def logs(user, events)
    @events = events
    @user = user
    @yesterday = DateTime.now.yesterday.strftime("%b%e")
    mail(to: @user.email, subject: "Morning! Here's what happened yesterday - #{yesterday}")
  end
end
