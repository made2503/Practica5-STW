require "test/unit"
require "rack/test"
require "./lib/RockPaperScissors"

class RPSTest < Test::Unit::TestCase
	include Rack::Test::Methods
	attr_reader :anwser

	def app
		Rack::Builder.new do
			run RockPaperScissors::RPS.new	
		end
	end

	def test_home
		get "/"
		#puts last_response.inspect
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

	def body
		super.join
	end

	def empty?
		[201,204,304,404].include? status
	end

	def assert_content(type)
		assert_equal type, response.headers['Content-Type']
	end

	def assert_status(code)
		assert_equal 200, response.status
	end

	def assert_body(body)
		assert_equal body, Array.wrap(response.body).join
	end
end