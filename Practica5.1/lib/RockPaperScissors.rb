require 'rack/request'
require 'rack/response'
require 'haml'
require 'thin'
require 'rack'
p "Iniciando Servidor en: http://localhost:8080"
module RockPaperScissors
	class RPS

		def initialize(app = nil)
			@app = app
			@content_type = :html
			@defeat = {'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper'}
			@throws = ''
		end

		def call env
			req = Rack::Request.new(env)
			player_throw = req.GET["choice"]
			@throws = @defeat.keys
			
			if !@throws.include?(player_throw)
				aux = "Choose one"
			else
				computer_throw = @throws.sample
			end
     		
			anwser = 
				if (player_throw == computer_throw && (player_throw != '' && computer_throw != ''))
					"TIE"
				elsif computer_throw == @defeat[player_throw]
					"WIN"
				else
					"LOSE"
				end

			engine = Haml::Engine.new File.open("views/index.html.haml").read
			res = Rack::Response.new
			
			res.write engine.render({},
				:anwser => anwser,
				:choose => @choose,
				:throws => @throws,
				:computer_throw => computer_throw,
				:player_throw => player_throw,
				:aux => aux)
			res.finish
		end #call
	end #Clase
end #Modulo
