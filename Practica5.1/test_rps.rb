require "test/unit"
require "rack/test"
require "./lib/RockPaperScissors"

class RPSTest < Test::Unit::TestCase
	include Rack::Test::Methods
end