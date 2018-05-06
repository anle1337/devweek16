
if ENV["REDISCLOUD_URL"]
    $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
else
  $redis = Redis.new(:host => 'localhost', :port => 6379)
end



# $redis = Redis.new(:url => "redis://rediscloud:devweeksuxs@pub-redis-17785.us-west-2-1.1.ec2.garantiadata.com:17785")
