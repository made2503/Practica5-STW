require "test/unit"
require "rack/test"
require "./lib/RockPaperScissors"

class RPSTest < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		Rack::Builder.new do
			run RockPaperScissors::RPS.new	
		end
	end

	def test_index
		get "/"
		#puts last_response.inspect
		assert last_response.ok?
	end

	def test_header
		get "/"
		last_response.header == 'Content-Length'
	end


	def test_status
		get "/test-url", {}, {"HTTP_IF_NONE_MATCH" => '"15-xyz"'}
		last_response.status == 200
	end

	def body
		super.join
	end

	def assert_content(type)
		assert_equal type, response.headers['Content-Type']
	end

	def empty?
		[201,204,304,404].include? status
	end

	def assert_status(code)
		assert_equal 200, response.status
	end
end