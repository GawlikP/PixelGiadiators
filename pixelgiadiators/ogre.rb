require "gosu"
require_relative "enemy"

class Ogre < Enemy
	def initialize x,y
		super x,y
		@animation_timer = 0.0;
		@animation_time = 300.0;
		@animation_frames = 4;
		@actual_frame = 1;
		@right = true;
		@moving = false;
		@range = 4.0;
		@speed = 0.01;
	end
	def update(delta,player)
		@animation_timer+= delta;
		if(@animation_timer > @animation_time)
			@animation_timer = 0.0;
			@actual_frame+=1;
		end
		if (@actual_frame > @animation_frames)
			@actual_frame = 1;
		end
		if(@vx > 0)
			@right = true
		end
		if(@vx < 0)
			@right = false;
		end
		if(@vx > 0.0001 or @vx < -0.0001 or @vy > 0.0001 or @vy < -0.0001)
			@moving= true;
		else 
			@moving= false;
		end
		super
	end
	def draw(scale,ogre_idle,ogre_walking1,ogre_walking2,ogre_walking3)
		
		x = @x;
		if(@right)
			scale_x = scale;

		end
		if(!@right)
			scale_x = -scale;
			x=x+@w
		end

		if(@moving)
			if(@actual_frame == 1)
				ogre_idle.draw(x*scale,@y*scale,0,scale_x,scale);
			end
			if(@actual_frame == 2)
				ogre_walking1.draw(x*scale,@y*scale,0,scale_x,scale);
			end
			if(@actual_frame == 3)
				ogre_walking2.draw(x*scale,@y*scale,0,scale_x,scale);
			end
			if(@actual_frame == 4)
				ogre_walking3.draw(x*scale,@y*scale,0,scale_x,scale);
			end
		else
			ogre_idle.draw(x*scale,@y*scale,0,scale_x,scale);
		end
	end
end