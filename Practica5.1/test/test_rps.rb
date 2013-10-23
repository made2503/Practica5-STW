require "test/unit"
require "rack/test"
require "./lib/RockPaperScissors"

ENV['RACK_ENV'] = 'test'

class RPSTest < Test::Unit::TestCase
	#include Rack::Test::Methods
	
	#def setup
	#	@browser = Rack::Test::Session.new(Rack::MockSession.new(RockPaperScissors::RPS.new))
	#end

	#def app
	#	Rack::Builder.new do
	#		run @browser
			#run RockPaperScissors::RPS.new	
	#	end
	#end

	def choice_computer
		computer_throw = 'paper'
	end

	def test_win
		browser = Rack::Test::Session.new(Rack::MockSession.new(RockPaperScissors::RPS.new))
		browser.get"/?choice='rock'"
		assert browser.last_response.body.include?("WIN")
	end

	def test_footer
		browser = Rack::Test::Session.new(Rack::MockSession.new(RockPaperScissors::RPS.new))
		browser.get "/"
		assert_match "<h6> Madelaine Martin Pazo. </h6>", browser.last_response.body
	end

	def test_title
		browser = Rack::Test::Session.new(Rack::MockSession.new(RockPaperScissors::RPS.new))
		browser.get "/"
		assert_match "<title> RPS </title>", browser.last_response.body
	end

	def test_home
		browser = Rack::Test::Session.new(Rack::MockSession.new(RockPaperScissors::RPS.new))
		browser.get "/"
		assert @browser.last_response.ok?
	end

	def test_header
		browser = Rack::Test::Session.new(Rack::MockSession.new(RockPaperScissors::RPS.new))
		browser.get "/"
		browser.last_response.header == 'Content-Type'
	end


	def test_status
		browser = Rack::Test::Session.new(Rack::MockSession.new(RockPaperScissors::RPS.new))
		browser.get "/test-url", {}, {"HTTP_IF_NONE_MATCH" => '"15-xyz"'}
		browser.last_response.status == 200
	end

	def test_body
		browser = Rack::Test::Session.new(Rack::MockSession.new(RockPaperScissors::RPS.new))
		browser.get "/"
		assert browser.last_response.body.include?("PLAY HERE!")
	end
end