class StaticPagesController < ApplicationController
	def home

	end

	def text_api
		api_key = 'f2b78c50-d35e-11e5-8378-4dad29be0fab'




		base_url = 'http://api.cortical.io/rest/retinas'



		sentiment_url = '/GetSentiment?'


		text = "Text=This+sucks"



		@test = HTTParty.get("#{base_url}", :headers => { "Accept" => "application/json", "Content-Type" => "application/json", "api-key" => api_key }, :debug_output => $stdout )
		# directory = HTTParty.get("#{BASE_URI}/employees/directory", {:basic_auth => {:username => API_KEY }, :headers => {"Accept" => "application/json" }})

		


	end

	def total_tweets
	@tweets = $twitter.search("#devweek16", {:search_type => "recent"})
	end

	def redis_test

		@redis = $redis.hgetall(1)["test_string"]
	end

	def update_redis



	$redis.hmset(1, "test_string", params[:hello][:text])

		params[:hello][:text]
		redirect_to redis_test_path
		flash[:success] = "#{params}"
	end
end

