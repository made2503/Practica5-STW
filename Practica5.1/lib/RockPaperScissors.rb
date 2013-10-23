require 'rack/request'
require 'rack/response'
require 'haml'
require 'thin'
require 'rack'

p "Vaya a la página http://localhost:8080"

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

		def set_env(env)
			@env = env
			@session = env['rack.session']
		end

		def won
			return @session['won'].to_i if @session['won']
			@session['won'] = 0
		end

		def won=(value)
			@session['won'] = value
		end

		def lost
			return @session['lost'].to_i if @session['lost']
			@session['lost'] = 0
		end

		def lost=(value)
			@session['lost'] = value
		end

		def tied
			return @session['tied'].to_i if @session['tied']
			@session['tied'] = 0
		end

		def tied=(value)
			@session['tied'] = value
		end
		
		def play
			return @session['play'].to_i if @session['play']
			@session['play'] = 0
		end

		def play=(value)
			@session['play'] = value
		end

		def call env
			set_env(env)
			req = Rack::Request.new(env)
			player_throw = req.GET["choice"]
			@throws = @defeat.keys
			
			if !@throws.include?(player_throw)
				aux = "Choose one"
			else
				computer_throw = @throws.sample
				self.play= self.play + 1
			end
     		
			anwser = 
				if (player_throw == computer_throw && (player_throw != '' && computer_throw != ''))
					"TIE"
				elsif computer_throw == @defeat[player_throw]
					"WIN"
				else
					"LOSE"
				end

			if anwser == "WIN"
				self.won= self.won + 1
			elsif anwser == "LOSE"
				self.lost= self.lost + 1
			elsif anwser == "TIE"
				self.tied= self.tied + 1
			end

			result =
				{
					:anwser => anwser,
					:choose => @choose,
					:throws => @throws,
					:computer_throw => computer_throw,
					:player_throw => player_throw,
					:aux => aux,
					:win => self.won,
					:playit => self.play,
					:lose => self.lost,
					:tie => self.tied,
				}

			res = Rack::Response.new(haml("views/index.html.haml", result))
			#res.write("some_key = #{@session['some_key']}\n")
			res.finish
		end #call
	end #Clase
end #Modulo
