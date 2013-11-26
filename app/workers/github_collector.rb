# Grabs all pull requests and commits from yesterday
# Converts data to JSON and saves in redis to be emailed later.
class GithubCollector < DataCollector

  def collect_events
    @github_api = integration.github_login
    @username = integration.username

    @commit_count = 0
    @pull_request_count = 0

    processed_events = []
    github_events.each do |e|
      event = process_event(e)
      processed_events = processed_events | event if event
    end

    tweet_events if processed_events.count > 0
    return processed_events
  end

  # retrieves all of yesterdays events
  # github only returns 30 a time. So keep pulling events until past yesterday
  # this is recursive
  def github_events(page = 1)
    all_events = []

    events = @github_api.activity.events.performed(@username, page: page)

    return all_events if events.count == 0

    events.each do |e|
      if from_today_or_yesterday?(e)
        all_events << e
      else
        return all_events
      end
    end

    all_events = all_events | github_events(page+1)
  end

  def pull_request_event(e)
    {
      type: 'Pull Request',
      action: e.payload.action,
      title: e.payload.pull_request.title,
      link: e.payload.pull_request.html_url,
      body: e.payload.pull_request.body,
      repo_name: e.repo.name,
      time: DateTime.parse(e.created_at)
    }
  end

  def commit_event(e, commit)
    {
      type: 'Commit',
      title: commit.message,
      link: commit.url,
      repo_name: e.repo.name,
      time: DateTime.parse(e.created_at)
    }
  end

  # Break out commit data from each Github Push
  def push_event(event)
    commits = []
    event.payload.commits.each do |commit|
      commits << commit_event(event, commit)
    end
    return commits
  end

  def process_event(event)
    case event[:type]
    when "PullRequestEvent"
      @pull_request_count += 1
      return [pull_request_event(event)]
    when "PushEvent"
      @commit_count += 1
      return push_event(event)
    end
  end

  def from_today_or_yesterday?(event)
    event_time = DateTime.parse(event.created_at).in_time_zone(@user.time_zone)

    (@user.current_time.to_date - 1.day) <= event_time.to_date
  end

  # Yesterday, on @github. I submitted 27 commits and 2 pull requests. @TheScrumBot
  def tweet_events
    return false unless @user.tweet?

    msg = []

    msg << "#{@commit_count} #{'commit'.pluralize(@commit_count)}" if @commit_count > 0
    msg << "#{@pull_request_count} pull #{'request'.pluralize(@pull_request_count)}" if @pull_request_count > 0

    tweet = "Yesterday, on @github, I submitted #{msg.join(' and ')}. @TheScrumBot"
    SendTweet.perform_in(8.hours, @user.id, tweet)
  end

  def integration
    @user.integrations.github
  end

end