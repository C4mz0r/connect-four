require 'spec_helper.rb'
require_relative '../player.rb'

describe Player do

	before(:each) do
		@player = Player.new("Frank", :red)	
	end

	it "should have a name" do
		expect(@player.name).to eq("Frank")
	end
	
	it "should have a color" do
		expect(@player.color).to eq(:red)
	end

end
