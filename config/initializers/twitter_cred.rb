# twitter = Twitter::REST::Client.new do |config|
#   config.consumer_key = ENV['CONSUMER_KEY']
#   config.consumer_secret = ENV['CONSUMER_SECRET']
#   config.access_token = ENV['YOUR_ACCESS_TOKEN']
#   config.access_token_secret = ENV['YOUR_ACCESS_SECRET']
# end


$twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = "oJR8rQd6it67rb52X7s5XEwsN"
  config.consumer_secret = "rNmocY2ORdM7qFBliAMU8oyAgOQPrrc8ja7QyicJaPvOjWJIw5"
  config.access_token = "2619220076-W6o58nC8n78ayub3SVq4nCaoNY9JBnQt0lKyRF9"
  config.access_token_secret = "AozRBguvC0mvBBxsq3Hq5eLA9arcGWvsIfbZwuKJ2hEUY"
end