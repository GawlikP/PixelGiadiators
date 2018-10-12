require "gosu"
class ManaPotion
	attr_accessor :x,:y,:w,:h,:add_mana
	def initialize x,y,add_mana
		@x = x;
		@y = y;
		@w = 8.0;
		@h = 8.0;
		@add_mana = add_mana;
	end
	def draw(scale,sprite)
		sprite.draw(@x*scale,@y*scale,0,scale,scale);
	end
end