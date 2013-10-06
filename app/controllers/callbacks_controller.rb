class CallbacksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def github
    github_api = GithubApi.init
    oauth_token = github_api.get_token(params[:code])

    github_api = GithubApi.init(oauth_token.token)
    username = github_api.users.get.login

    current_user.create_or_update_github_account!(username, oauth_token.token)
  
    redirect_to root
  end

  def google
  end

end