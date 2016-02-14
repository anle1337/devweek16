if ENV["REDISCLOUD_URL"]
    $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
end

$redis = Redis.new(:host => 'localhost', :port => 6379)