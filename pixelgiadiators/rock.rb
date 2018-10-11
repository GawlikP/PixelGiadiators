require "gosu"

class Rock
	attr_accessor :x, :y, :w,:h
	def initialize(x,y)
		@x = x
		@y = y
		@w = 8.0
		@h = 8.0
	end
	def draw(scale,sprite)
	#Gosu.draw_rect(@x*scale,@y*scale,@w*scale,@h*scale,0xff_00ff00);
	sprite.draw(@x*scale,@y*scale,0,scale,scale);
	end
end