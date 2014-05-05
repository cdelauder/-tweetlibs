require_relative 'view'
require_relative 'model'

class TweetLibs
  attr_accessor :genre

  def initialize(view, model)
    # If you work with class methods in the view and the model
    # (`def self.method`) you don't need to define them in this method.
    @view = view
    @model = model
    @user_1_tweets = []
    @user_2_tweets = []
  end

  def menu
    selection = @view.menu
    # Why not just @view.menu.to_i ???
    case selection.to_i
    when 1
      start_game
    when 2
      return
    else
      menu
    end
  end

  def start_game
    # I like the extraction of procedural code here.
    select_genre
    select_twitter_users
    select_tweets
    display_story
  end

  def select_twitter_users
    usernames = @view.select_twitter_users
    @model.select_twitter_users(usernames)
  end

  def select_genre
    @genre = @view.select_genre
    @model.select_genre(@genre)
  end

  def select_tweets
    @model.select_tweets
    until @user_1_tweets.length == 3
      make_tweet_selections
    end
  end

  def make_tweet_selections
    tweet_sample_1 = @model.sample_tweets_user_1
    tweet_sample_2 = @model.sample_tweets_user_2
    @user_1_tweets << tweet_sample_1[@view.select_tweets(tweet_sample_1) - 1]
    @user_2_tweets << tweet_sample_2[@view.select_tweets(tweet_sample_2) - 1]
  end

  def display_story
    story = @model.build_story(@user_1_tweets, @user_2_tweets)
    title = @model.get_title
    @view.display_story(story, title)
    clear_user_tweets
    menu
  end

  def clear_user_tweets
    @user_1_tweets = []
    @user_2_tweets = []
  end
end
