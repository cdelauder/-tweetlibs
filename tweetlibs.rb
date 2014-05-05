require_relative 'tests'
require_relative 'controller'

game = TweetLibs.new(View.new, Model.new)
game.menu
