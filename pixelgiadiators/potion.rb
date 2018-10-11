require "gosu";

class Potion
	attr_accessor :x,:y,:w,:h
	def initialize x,y
		@x = x;
		@y = y;
		@w = 8.0;
		@h = 8.0;
	end
	def show(scale,sprite)
		sprite.draw(@x*scale,@y*scale,0,scale,scale);
	end
end