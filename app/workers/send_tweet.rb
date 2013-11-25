# Sends a tweet on users behalf of what they got done
class SendTweet
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(user_id, message)
    user = User.find(user_id)
    twitter = twitter_client(user)
    
    twitter.update(message) if twitter
  end

  def twitter_client(user)
    twitter = user.integrations.twitter
    return false unless twitter

    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET'] 
      config.access_token        = twitter.token
      config.access_token_secret = twitter.secret
    end
  end

end