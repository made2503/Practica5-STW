require 'rack/request'
require 'rack/response'
require 'haml'
require 'thin'
require 'rack'

module RockPaperScissors
	class RPS

		def initialize(app = nil)
			@app = app
			@content_type = :html
			@defeat = {'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper'}
			@throws = ''
		end

		def haml(template, result)
			template_file = File.open(template, 'r')
			Haml::Engine.new(File.read(template_file)).render({}, result)
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

			result =
				{
					:anwser => anwser,
					:choose => @choose,
					:throws => @throws,
					:computer_throw => computer_throw,
					:player_throw => player_throw,
					:aux => aux,
				}

			res = Rack::Response.new(haml("views/index.haml", result))
			#res.write("some_key = #{@session['some_key']}\n")
			res.finish
		end #call
	end #Clase
end #Modulo
