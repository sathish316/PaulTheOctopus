require 'paul'
require 'with_cached_value'

username = ARGV[0] || 'octopuspaul42'
password = ARGV[1]

@paul = Paul.new
@paul.login(username, password)

while(true)
  with_cached_value("#{ENV['HOME']}/.paulrc",1) do |id|
    puts "Predicting tweets from...#{id}"
    sleep(45)
    @paul.predict(id)
  end
end
