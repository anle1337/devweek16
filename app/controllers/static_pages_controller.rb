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
		
		@tweetedSponsors = JSON.parse($redis.hget(1, "tweetedSponsors").gsub("=>", ":")).sort_by { |word, appearances| -appearances}

		@words = JSON.parse($redis.hget(1, "words").gsub("=>", ":")).sort_by { |word, appearances| -appearances}

		@hashtag_inc = JSON.parse($redis.hget(1, "hashtag_inc").gsub("=>", ":")).sort_by { |word, appearances| -appearances}



	end

	def update_tweets

		sponsors = %w{galvanize codeanywhere concierge dji flowroute havenondemand ibm capitalone cortical devbootcamp equinix gupshup intuit kony magnet microsoft netapp redislabs theta sparkpost}
		@tweetedSponsors = Hash.new(0)
		@words = {}
		@hashtag_inc = {}
		@tweets = $twitter.search("#{params[:search][:text]}", {:search_type => "recent"}).each do |tweet|

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

				sponsors.each do |sponsor|
					if word.include?(sponsor)
						@tweetedSponsors[sponsor] +=1
					end
				end

			end
		end
		

		$redis.hset(1, "words", @words)
		$redis.hset(1, "hashtag_inc", @hashtag_inc)
		$redis.hset(1, "tweetedSponsors", @tweetedSponsors)


		params[:search][:text]
		redirect_to total_tweets_path
		flash[:success] = "#{params[:search][:tweet]}"
		
	end



	def redis_test

		@redis = $redis.hgetall(1)["test_string"]

	end

	def update_redis
	$redis.hset(1, "tweet", params[:search][:text])

		params[:search][:text]
		redirect_to redis_test_path
		flash[:success] = "#{params[:search]}"
	end
	
	
end

# 1 {
# 	Search => {
# 		Hashtag => {
# 			“top_words” => {
# 		 		“word1” => 1,
# 				 “word2” => 3 
# 			},
# 			“top_hashtags" => {
# 				 “word1” => 1,
# 				 “word2” => 3
# 			}
# 		}
# 	}
# }


