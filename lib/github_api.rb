module GithubApi
  def self.init(token=nil)
    Github.new(client_id: ENV['GITHUB_CLIENT_ID'], 
               client_secret: ENV['GITHUB_SECRET'], 
               oauth_token: token)

  end
end