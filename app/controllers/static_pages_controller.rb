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
		
		@words = {}
		@hashtag_inc = {}
		@tweets = $twitter.search("#devweek16", {:search_type => "recent"}).each do |tweet|

			a = tweet.full_text.downcase.gsub(/[^#a-z0-9\s]/i, '').split(" ")
			a.pop

			a.each do |word|

				if @words.keys.include?(word) != true
					@words[word] = 1
				else
					@words[word] +=1
				end

				if word.include?("#")
					if @hashtag_inc.keys.include?(word) != true
						@hashtag_inc[word] = 1
					else
						@hashtag_inc[word] +=1
					end
				end
			end	
		end

		@words = @words.sort_by { |word, appearances| -appearances}
		@hashtag_inc = @hashtag_inc.sort_by { |word, appearances| -appearances}




	end

	def update_tweets
		
		@hashtag = params[:tweetz][:text]

		@words = $twitter.search("#{@hashtag}", {:search_type => "recent"}).each do |tweet|

			a = tweet.full_text.downcase.gsub(/[^a-z0-9\s]/i, '').split(" ")
			a.pop

			a.each do |word|

				if @words.keys.include?(word) != true
					@words[word] = 1
				else
					@words[word] +=1
				end
			end	
		end

		@words.take(100).each.with_index do |word, index|

			$redis.hmset(index, "tweet_info", word)

		end


		redirect_to total_tweets_path
		flash[:success] = "#{params}"
		
	end



	def redis_test

		@redis = $redis.hgetall(1)["test_string"]

	end

	def update_redis
	$redis.hmset(1, "test_string", params[:hello])

		params[:hello][:text]
		redirect_to redis_test_path
		flash[:success] = "#{params[:hello]}"
	end
end

