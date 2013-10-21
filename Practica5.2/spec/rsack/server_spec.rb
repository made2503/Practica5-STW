require 'spec_helper'

describe Rsack::Server do 
	def server
		Rack::MockRequest.new(Rsack::Server.new)
	end

	#PRINCIPAL
	context '/' do 

		it "Debería devolver el codigo 200" do 
			response = server.get('/')
			response.status.should == 200
		end

		it "Debería mostrar RPS" do 
			response = server.get('/')
			response.header == 'RPS'
		end
	end

	#SCISSORS
	context "/?choice='scissors'" do

		it "Debería devolver el código 200" do 
			response = server.get("/?choice='scissors'")
			response.status.should == 200
		end

		it "Debería mostrar unas tijeras" do
		 	response = server.get("/?choice='scissors'")
			response.body.include?("http://banot.etsii.ull.es/alu4103/tijeras2.png")
		end

		it "Debería ganar" do 
			computer_throw = 'paper'
			response = server.get("/?choice='scissors'")
			response.body.include?("PLAYER 1 WIN =)!")
		end

		it "Debería Perder" do 
			computer_throw = 'rock'
			response = server.get("/?choice='scissors'")
			response.body.include?("OUCH! PLAYER 2 WIN =(")
		end

		it "Debería Empatar" do 
			computer_throw = 'scissors'
			response = server.get("/?choice='scissors'")
			response.body.include?("TIE")
		end
	end

	#ROCK
	context "/?choice='rock'" do

		it "Debería devolver el código 200" do 
			response = server.get("/?choice='rock'")
			response.status.should == 200
		end

		it "Debería mostrar una roca" do
		 	response = server.get("/?choice='rock'")
			response.body.include?("http://banot.etsii.ull.es/alu4103/piedra2.png")
		end

		it "Debería ganar" do 
			computer_throw = 'scissors'
			response = server.get("/?choice='rock'")
			response.body.include?("PLAYER 1 WIN =)!")
		end

		it "Debería Perder" do 
			computer_throw = 'paper'
			response = server.get("/?choice='rock'")
			response.body.include?("OUCH! PLAYER 2 WIN =(")
		end

		it "Debería Empatar" do 
			computer_throw = 'rock'
			response = server.get("/?choice='rock'")
			response.body.include?("TIE")
		end
	end

	#PAPER
	context "/?choice='paper'" do

		it "Debería devolver el código 200" do 
			response = server.get("/?choice='paper'")
			response.status.should == 200
		end

		it "Debería mostrar un papel" do
		 	response = server.get("/?choice='paper'")
			response.body.include?("http://banot.etsii.ull.es/alu4103/papel2.png")
		end

		it "Debería ganar" do 
			computer_throw = 'rock'
			response = server.get("/?choice='paper'")
			response.body.include?("PLAYER 1 WIN =)!")
		end

		it "Debería Perder" do 
			computer_throw = 'scissors'
			response = server.get("/?choice='paper'")
			response.body.include?("OUCH! PLAYER 2 WIN =(")
		end

		it "Debería Empatar" do 
			computer_throw = 'paper'
			response = server.get("/?choice='paper'")
			response.body.include?("TIE")
		end
	end

end
