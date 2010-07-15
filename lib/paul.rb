require 'rubygems'
require 'twitter'

class Paul

  def login(username, password)
    @name = username
    auth = Twitter::HTTPAuth.new(username, password)
    @client = Twitter::Base.new(auth)
  end

  def predict(since_id)
    last_id = since_id
    requests = requests_since(since_id)
    requests.each do |req_id, user, query|
      begin
        puts "Predicting @#{user} - #{req_id}"
        last_id = req_id if req_id > last_id
        tweet_prediction_for(user, query)
      rescue => e
        puts "WTF: #{e.message}"
      end
    end
    last_id
  end

  def requests_since(since_id)
    @client.mentions(:since_id => since_id).collect do |mention|
      [mention.id, mention.user.name, query(mention.text)]
    end
  end

  def tweet_prediction_for(user,query)
    prediction = choose(query)
    @client.update("@#{user}: #{prediction}") if prediction
  end

  protected

  def query(tweet)
    tweet.match(/@#{@name}:?\s*(.*)/)[1]
  end

  def choose(query)
    return if query.nil?
    options = query.scan(/\[(.*?)\]/).flatten
    return 42 if options.size <= 1
    return "Yes" if options.map(&:upcase).include? 'YES'
    prediction = options[rand(42+1) % options.size]
    prediction
  end

end

