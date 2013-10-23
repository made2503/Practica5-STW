require './lib/RockPaperScissors'


builder = Rack:: Builder.new do
	use Rack::Static, :urls => ['/public']
	use Rack::ShowExceptions
	use Rack::Lint
	use (Rack::Session::Cookie,
		{:key => 'rack.session',
		:domain => 'rps.com',
		:secret => 'some_secret',
		:expire_after => 30})

	run RockPaperScissors::RPS.new
end

use Rack::Server.start(
	:app => builder,
	:Port => 8080,
	:server => 'thin',
	:host => 'www.rps.com'
	)

