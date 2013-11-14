class MorningMailer < ActionMailer::Base
  default from: "goodmorning@scrumlogs.com"
  layout 'email'
   
  def scrum_update(user_id)
    @user = User.find(user_id)
    time = Time.now.in_time_zone(@user.time_zone)
    @day = time.strftime("%A")

    @events = JSON.parse(@user.integrations.github.todays_events)

    @pull_requests, @commits = Integration.parse_github_events(@events)

    subject = "What you got done yesterday (#{time.yesterday.strftime("%a, %b %d")})"
    mail(to: @user.email, subject: subject)
  end

end
