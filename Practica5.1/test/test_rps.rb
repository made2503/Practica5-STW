require "test/unit"
require "rack/test"
require "./lib/RockPaperScissors"


class RPSTest < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		Rack::Session::Cookie.new(RockPaperScissors::RPS.new,
			:secret => 'cookie')
	end

	def choice_computer
		computer_throw = 'paper'
	end

	def test_win
		get"/?choice='rock'"
		assert last_response.body.include?("WIN")
	end

	def test_title
		get "/"
		assert_match "<title>RPS</title>", last_response.body
	end

	def test_home
		get "/"
		assert last_response.ok?
	end

	def test_header
		get "/"
		last_response.header == 'Content-Type'
	end


	def test_status
		get "/test-url", {}, {"HTTP_IF_NONE_MATCH" => '"15-xyz"'}
		last_response.status == 200
	end

	def test_body
		get "/"
		assert last_response.body.include?("PLAY HERE!")
	end
end