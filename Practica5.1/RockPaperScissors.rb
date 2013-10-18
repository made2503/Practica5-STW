require './lib/RockPaperScissors'


builder = Rack:: Builder.new do
	use Rack::Static, :urls => ['/public']
	use Rack::ShowExceptions
	use Rack::Lint
	use Rack::Session::Cookie,
		:key => 'rack.session',
		:domain => 'RockPaperScissors.com',
		:secret => 'some_secret'

	run RockPaperScissors::RPS.new
end

Rack::Handler::Thin.run builder

