# Grabs all pull requests and commits from yesterday
# Converts data to JSON and saves in redis to be emailed later.
class GithubCollector < DataCollector

  def collect_events
    @github_api = @user.integrations.github.github_login
    @username = @user.integrations.github.username

    processed_events = []
    github_events.each do |e|
      event = process_event(e)
      processed_events = processed_events | event if event
    end

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
      description: commit.message,
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
      return [pull_request_event(event)]
    when "PushEvent"
      return push_event(event)
    end
  end

  def from_today_or_yesterday?(event)
    event_time = DateTime.parse(event.created_at).in_time_zone(@user.time_zone)

    (current_user_time.to_date - 1.day) <= event_time.to_date
  end

  def integration_name
    'Github'
  end

end