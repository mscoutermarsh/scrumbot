class IntegrationsController < ApplicationController
  before_filter :authenticate_user!

  def github
    c_id = ENV['GITHUB_CLIENT_ID']
    redirect_to "https://github.com/login/oauth/authorize?client_id=#{c_id}&scope=repo"
  end

  def google
    #TODO
  end

end