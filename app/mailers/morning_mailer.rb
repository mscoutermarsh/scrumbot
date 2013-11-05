class MorningMailer < ActionMailer::Base
  default from: "goodmorning@scrumlogs.com"
   
  def scrum_update(user)
    @user = user
    time = Time.now.in_time_zone(user.time_zone)
    @day = time.strftime("%A")

    events = @user.todays_events

    subject = "What you got done yesterday (#{time.yesterday.strftime("%a, %b %d")})"
    mail(to: @user.email, subject: subject)
  end

end
