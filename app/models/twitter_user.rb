class TwitterUser < ActiveRecord::Base
  has_many :tweets

	def fetch_tweets(username)
		@twitter_user = TwitterUser.find_or_create_by(username: username)
		@tweets = @twitter_user.tweets

		if !@tweets.empty?
			@twitter_user.tweets.destroy_all
		end

		@tweets = $client.user_timeline(username, count: 10)
		@tweets.each do |tweet|
		@twitter_user.tweets.create(text: tweet.text)
		end
	end



end
