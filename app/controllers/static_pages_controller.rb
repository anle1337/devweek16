class StaticPagesController < ApplicationController
	def home

	end

	def total_tweets
	@tweets = $twitter.search("#devweek16", {:search_type => "recent"})
	end

	def redis_test

		@redis = Redis.new.hgetall(1)["test_string"]
	end

	def update_redis


	redis = Redis.new
	redis.hmset(1, "test_string", params[:hello][:text])

		params[:hello][:text]
		redirect_to redis_test_path
		flash[:success] = "#{params}"
	end
end

