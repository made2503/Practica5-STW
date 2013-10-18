module Rsack
	class Server
		def call env
			response = Rack::Response.new
			response.write("")
			response.finish
		end
	end
end