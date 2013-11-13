class CallbacksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def github
    github = Github.new(client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_SECRET'])
    github.oauth_token = github.get_token(params[:code]).token

    username = github.users.get.login

    integration = current_user.create_or_update_github_account!(username, github.oauth_token)
    
    if integration
      redirect_to after_signup_path(:complete),
        success: "Github connected successfully!"
    else
      redirect_to after_signup_path(:link_github),
        alert: "Unable to link your Github account!"
    end
  end

  def google
  end

end