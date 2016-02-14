if ENV["REDISCLOUD_URL"]
    $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
end

# $redis = Redis.new(:host => 'localhost', :port => 6379)

# $redis = Redis.new(:url => "redis://rediscloud:devweeksuxs@pub-redis-17785.us-west-2-1.1.ec2.garantiadata.com:17785")