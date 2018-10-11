require "gosu";
require_relative "sprites";
require_relative "player";
require_relative "rock"
require_relative "gold_sack"
require_relative "enemy"
$SCREEN_W = 240;
$SCREEN_H = 144;
$SCALE = 3;
$NOW = 0.0;
$LAST = 0.0;
$DELTA = 0.0;


$TERRAIN_OBJECTS = [];
$ITEMS = [];
$ENEMIES = [];
$FONT = Gosu::Font.new(16);
class Window < Gosu::Window
	def initialize
		super $SCREEN_W*$SCALE, $SCREEN_H*$SCALE;
		self.caption = "game"; 
		$NOW = Gosu.milliseconds;
		@player = Player.new();
		$TERRAIN_OBJECTS.push(Rock.new(30.0,30.0));
		$ITEMS.push(GoldSack.new(60.0,60.0,15));
		$ENEMIES.push(Enemy.new(100.0,100.0));
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
		$ENEMIES.each do |x|
			x.player_detection(@player);
			x.update($DELTA,@player);
			x.player_attacking(@player);
		end
		$ITEMS.delete_if do |x|
			if x.is_a?(GoldSack)
				if @player.GoldCollision(x)
					true;
				end
			end
		end
	end
	def draw
		@player.UI($FONT);
		$TERRAIN_OBJECTS.each do |x|
			x.draw($SCALE,$ROCK_SPRITE);
		end
		$ITEMS.each do |x|
			x.draw($SCALE,$GOLD_SACK_SPRITE);
		end
		$ENEMIES.each do |x|
			x.draw($SCALE);
		end
		@player.draw($VIKING_IDLE,$VIKING_WALKING1,$VIKING_WALKING2,$VIKING_WALKING3,$VIKING_WALKING4,$SCALE);

	end
end

test = Window.new.show;