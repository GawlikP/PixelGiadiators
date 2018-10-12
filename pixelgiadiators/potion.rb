require "gosu";

class Potion
	attr_accessor :x,:y,:w,:h,:add_hp
	def initialize x,y,add_hp
		@x = x;
		@y = y;
		@w = 8.0;
		@h = 8.0;
		@add_hp = add_hp
	end
	def draw(scale,sprite)
		sprite.draw(@x*scale,@y*scale,0,scale,scale);
	end
end