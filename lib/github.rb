module Github
  def github_api(token=nil)
    Github.new(client_id: configatron.github.client_id, 
               client_secret: configatron.github.secret,
               oauth_token: token)
  end
end