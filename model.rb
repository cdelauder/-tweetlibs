require 'sqlite3'
require 'twitter'

# I think that you have several models in your system and they are all in this
# class. Story, Tweet, and User all seem like good candidates for models, but
# StoryTemplate is the only model which appears to have a database backing.

class Model

  def initialize
    @user_1_tweets = []
    @user_2_tweets = []
    @tweetlibs_database = SQLite3::Database.new "tweetlibs-database.db"
    # I think that you have a missing object in your system which is
    # responsible for talking with your API, and contains this code (which is
    # duplicated from the api.rb file). Something like TwitterAPI
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "V9fa9p8YxOPtjE9YTcxjYztlr"
      config.consumer_secret     = "g9Ee6hJe094DowCyD4Oyecui39a6Nynt31uzKDXK4uOgl9vFML"
      config.access_token        = "171597575-KikuQ7884uFrBP9GLmh8ejrdDEfnGsTA9aOlJvQb"
      config.access_token_secret = "kLccAab1THvQPHVIH2lzhOUPv7XfQTHnEqtQVirQlt1s7"
    end
  end

  def get_tweets(twittername, num_of_tweets)
    # This code is duplicated across your API and model code. Decide where the
    # code lives and put it there.
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


  def select_genre(genre)
    # This menu case statement logic would fit better in the controller.
    case genre.to_i
    when 1
      @genre = 'Science Fiction'
    when 2
      @genre = 'Horror'
    else
      @genre = 'Romance'
    end
    @genre
  end

  def sample_tweets_user_1
    @user_1_tweets.pop(3)
  end

  def sample_tweets_user_2
    # This duplicates the method above it. Could you make the method take or be
    # called an object and then work off of the object in question.
    @user_2_tweets.pop(3)
  end

  def select_twitter_users(usernames)
    @twittername1 = usernames[0]
    @twittername2 = usernames[1]
  end

  def select_tweets
    @user_1_tweets = get_tweets(@twittername1,9)
    @user_2_tweets = get_tweets(@twittername2,9)
  end

  def build_story(user_1_tweets, user_2_tweets)
    @story = get_story_from_database[0][0]
    user1_replace = { user1_1: "#{user_1_tweets[0]}", user1_2: "#{user_1_tweets[1]}", user1_3: "#{user_1_tweets[2]}" }
    user2_replace = { user2_1: "#{user_2_tweets[0]}", user2_2: "#{user_2_tweets[1]}", user2_3: "#{user_2_tweets[2]}" }

    user1_replace.each { |key,value| @story.sub!(key.to_s, value) }
    user2_replace.each { |key,value| @story.sub!(key.to_s, value) }
    @story
  end

  def get_title
    title = @tweetlibs_database.execute("SELECT title FROM story_templates WHERE genre = '#{@genre}';")
    @title = title[0][0]
  end

  def get_story_from_database
    @tweetlibs_database.execute("SELECT story FROM story_templates WHERE genre = '#{@genre}';")
  end
end
