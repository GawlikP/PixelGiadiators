require "gosu";
require_relative "sprites";
require_relative "player";
require_relative "rock"
require_relative "gold_sack"
require_relative "enemy"
require_relative "ogre"
require_relative "potion"
require_relative "mana_potion"
$SCREEN_W = 240;
$SCREEN_H = 144;
$SCALE = 4;
$NOW = 0.0;
$LAST = 0.0;
$DELTA = 0.0;


$TERRAIN_OBJECTS = [];
$ITEMS = [];
$ENEMIES = [];
$ANIMATION = [];
$FONT = Gosu::Font.new(16);
class Window < Gosu::Window
	def initialize
		super $SCREEN_W*$SCALE, $SCREEN_H*$SCALE;
		self.caption = "game"; 
		$NOW = Gosu.milliseconds;
		@player = Player.new();
		$TERRAIN_OBJECTS.push(Rock.new(30.0,30.0));
		$ITEMS.push(GoldSack.new(60.0,60.0,15));
		$ITEMS.push(Potion.new(70.0,70.0,10.0));
		$ITEMS.push(ManaPotion.new(100.0,20.0,5.0));
		$ENEMIES.push(Enemy.new(100.0,100.0));
		$ENEMIES.push(Ogre.new(120.0,120.0));
	end
	def update
		self.caption ="#{Gosu.fps}";
		$LAST = $NOW;
		$NOW = Gosu.milliseconds;
		$DELTA = $NOW - $LAST;
		@player.moving
		@player.update($DELTA)
		$TERRAIN_OBJECTS.each do |x|
			@player.collision(x)
		end
		$ENEMIES.delete_if do |x|
			if(x.hp < 0)
				true;
			end	
		end
		$ENEMIES.each do |x|
			x.player_detection(@player);
			x.update($DELTA,@player);
			x.player_attacking(@player);
			@player.attacking(x);
		end
		$ITEMS.delete_if do |x|
			if x.is_a?(GoldSack)
				if @player.GoldCollision(x)
					true;
				end
			elsif x.is_a?(Potion) or x.is_a?(ManaPotion)
				if @player.PotionCollision(x);
					true;
				end
			end
		end
		$ANIMATION.each do |x|
			x.update(x)
		end
		$ANIMATION.delete_if do |x|
			if(x.act_frame > x.frames)
				@player.
			end
		end
	end
	def draw
		Gosu.draw_rect(0,0,$SCREEN_W*$SCALE,$SCREEN_H*$SCALE,0xff_ffffff);
		@player.UI($FONT);
		$TERRAIN_OBJECTS.each do |x|
			x.draw($SCALE,$ROCK_SPRITE);
		end
		$ITEMS.each do |x|
			if x.is_a?(GoldSack)
				x.draw($SCALE,$GOLD_SACK_SPRITE);
			elsif x.is_a?(Potion)
				x.draw($SCALE,$HEALTH_POTION_SPRITE);
			elsif x.is_a?(ManaPotion)
				x.draw($SCALE,$MANA_POTION_SPRITE);
			end	
		end
		$ENEMIES.each do |x|
			if x.is_a?(Ogre)
				x.draw($SCALE,$OGRE_IDLE,$OGRE_WALKING1,$OGRE_WALKING2,$OGRE_WALKING3);
			else
			end


		end
		@player.draw($VIKING_IDLE,$VIKING_WALKING1,$VIKING_WALKING2,$VIKING_WALKING3,$VIKING_WALKING4,$SCALE)do
		$ANIMATION.each do |x|
			if(x.where == "Player")
				x.draw;
			end
		end
		end

	end
end

test = Window.new.show;