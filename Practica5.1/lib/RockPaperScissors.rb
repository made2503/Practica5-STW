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
			@cont_win = 0
			@cont_loose = 0
			@cont_tie = 0
		end

		def haml(template, result)
			template_file = File.open(template, 'r')
			Haml::Engine.new(File.read(template_file)).render({}, result)
		end

		def set_env(env)
			@env = env
			@session = env['rack.session']
		end

		def some_key
			return @session['some_key'].to_i if @session['some_key']
			@session['some_key'] = 0
		end

		def some_key=(value)
			@session['some_key'] = value
		end

		def call env
			set_env(env)
			req = Rack::Request.new(env)
			player_throw = req.GET["choice"]
			@throws = @defeat.keys
			cont_win = 0
			cont_tie = 0
			cont_loose = 0

			self.some_key = self.some_key + 1 if req.path == '/'
			
			if !@throws.include?(player_throw)
				aux = "Choose one"
			else
				computer_throw = @throws.sample
			end
     		
			anwser = 
				if (player_throw == computer_throw && (player_throw != '' && computer_throw != ''))
					@cont_tie = @cont_tie + 1
					"TIE"
				elsif computer_throw == @defeat[player_throw]
					@cont_win = @cont_win + 1
					"WIN"
				else
					@cont_loose = @cont_loose + 1
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
					:cont_tie => @cont_tie,
					:cont_loose => @cont_loose,
					:cont_win => @cont_win
				}
				
			res = Rack::Response.new(haml("views/index.html.haml", result))
			res.write("some_key = #{@session['some_key']}\n")
			res.finish
		end #call
	end #Clase
end #Modulo
