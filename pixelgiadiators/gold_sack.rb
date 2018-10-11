require "gosu";

class GoldSack
	attr_accessor :x, :y, :w ,:h, :mout_of_gold
	def initialize x, y, g
		@x = x;
		@y = y;
		@w = 8.0;
		@h = 8.0;
		@mout_of_gold = g;
	end
	def draw(scale,sprite)
		sprite.draw(@x*scale,@y*scale,0,scale,scale);
	end
end