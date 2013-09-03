class CallbacksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def github
    access_token = github_api.get_token(params[:code])

    username = github_api(access_token.token).users.get.login

    app = Application.find_by_description('Github')
    account = current_user.accounts.find_or_create_by_application_id(app.id)
    account.update_attributes(access_secret: access_token.token, active: true, username: username)
  

    redirect_to accounts_path
  end

end