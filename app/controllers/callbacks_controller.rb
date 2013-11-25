class CallbacksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def github
    github = Github.new(client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_SECRET'])
    github.oauth_token = github.get_token(params[:code]).token

    integration = current_user.create_or_update_github_account!(github.users.get.login, github.oauth_token)
    
    if integration
      redirect_to after_signup_path(:link_twitter),
        success: "Github connected successfully!"
    else
      redirect_to after_signup_path(:link_github),
        alert: "Unable to link your Github account!"
    end
  end

  def twitter
    auth = request.env["omniauth.auth"]

    integration = current_user.create_or_update_twitter_account!(auth.info.nickname, auth.credentials.token, auth.credentials.secret)
    
    if integration
      current_user.update_attributes(tweet: 'true')
      redirect_to after_signup_path(:complete),
        success: "Twitter connected successfully!"
    else
      redirect_to after_signup_path(:link_twitter),
        alert: "Unable to link your Twitter account!"
    end
  end

  def google
  end

end