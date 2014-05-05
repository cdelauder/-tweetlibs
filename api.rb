require 'twitter'

@client = Twitter::REST::Client.new do |config|
  # Instead of leaving API keys in your code, you can consume them from an
  # ignored file. See Dotenv
  # https://github.com/bkeepers/dotenv
  config.consumer_key        = "V9fa9p8YxOPtjE9YTcxjYztlr"
  config.consumer_secret     = "g9Ee6hJe094DowCyD4Oyecui39a6Nynt31uzKDXK4uOgl9vFML"
  config.access_token        = "171597575-KikuQ7884uFrBP9GLmh8ejrdDEfnGsTA9aOlJvQb"
  config.access_token_secret = "kLccAab1THvQPHVIH2lzhOUPv7XfQTHnEqtQVirQlt1s7"
end

def get_tweets(twittername, num_of_tweets)
  # This method could be broken up, decomposed into several smaller methods.
  #
  # Use map instead of each to return a new array of sanitized tweets.

  strings = []
  tweets = @client.user_timeline(twittername)
  raise ArgumentError, 'Please input Twitter handle with at least 10 tweets.' unless tweets.length >= 10

  tweets.sample(num_of_tweets).each do |tweet|
    remove_urls_hagtags = /(https?:\/\/)?([\da-zA-Z\.-]+)\.([a-zA-Z\.]{2,6})([\/\w\.-]*)*\/?|@\w+|#\w+/
    remove_punctuations = /(\.|!|:|--|-)?$/
    urls_removed = tweet.text.gsub(remove_urls_hagtags, "").strip
    punc_removed = urls_removed.gsub(remove_punctuations, "").strip
    strings << punc_removed if punc_removed.length > 2
  end

  strings
end
