require 'active_support/concern'

module GithubHelper
  extend ActiveSupport::Concern

  included do
    scope :github, -> { where(account: Account.find_by_name('Github')).first }
  end

  # can we connect to Github API with correct permissions?
  def github_valid?
    github_login.scopes.list.include? "repo"
  rescue Github::Error::GithubError
    return false
  end

  def github?
    account == Account.find_by_name('Github')
  end

  def github_login
    Github.new oauth_token: token
  end

  module ClassMethods
    def parse_github_events(events)
      pull_requests = events.select { |e| e['type'] == 'Pull Request' }
      commits = events.select { |e| e['type'] == 'Commit' }

      [pull_requests, commits]
    end
  end

end