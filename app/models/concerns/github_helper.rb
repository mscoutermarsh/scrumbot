require 'active_support/concern'

module GithubHelper
  extend ActiveSupport::Concern

  included do
    scope :github, -> { where(account: Account.find_by_name('Github')).first }
  end

  # can we connect to Github API with correct permissions?
  def github_valid?
    return false unless github?

    github_login.scope.list.include? "repo"

  rescue Github::Error::GithubError
    return false
  end

  def github?
    account == Account.find_by_name('Github')
  end

  def github_login
    return false unless github?
    Github.new oauth_token: access_secret
  end

  module ClassMethods
  end
end