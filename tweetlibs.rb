=begin

# instantiate our game class
# call our menu function

=end
# require 'ping'
require_relative 'tests'
require_relative 'controller'

# if Ping.pingecho "twitter.com"
game = TweetLibs.new(View.new, Model.new)
game.menu
# else
#   puts "Sorry! You need to be connected to the internet first!"
# end




