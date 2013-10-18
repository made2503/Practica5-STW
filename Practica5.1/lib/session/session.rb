class RPS

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
		res = Rack::Response.new
		req = Rack::Request.new env

		self.some_key = self.some_key + 1 if req.path == '/'

		res.write("some_key = #{@session['some_key']}\n")

		res.finish
	end
end