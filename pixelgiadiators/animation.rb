require "gosu"

class Animation
	attr_accessor :x,:y,:w,:h,:speed,:where,:act_frame,:frames
	def initialize x,y,w,h,speed,where
		@x = x;
		@y = y;
		@w = w;
		@h = h;
		@speed =speed;
		@frames = 5;
		@act_frame = 1;
		@frame_timer 0.0;
		@where = where;
	end
	def update(dt)
		@frame_timer += dt;
		if(@frame_timer > @speed)
			@act_frame++;
			@frame_timer=0.0;
		end
		
	end
	def show(scale,frame1,frame2,frame3,frame4,frame5)
		if(@act_frame == 1)
			frame1.draw(@x*scale,@y*scale,0,scale,scale);
		elsif @act_frame == 2
			frame2.draw(@x*scale,@y*scale,0,scale,scale);
		elsif @act_frame == 3
			frame3.draw(@x*scale,@y*scale,0,scale,scale);
		elsif @act_frame == 4
			frame4.draw(@x*scale,@y*scale,0,scale,scale);
		elsif @act_frame == 5
			frame5.draw(@x*scale,@y*scale,0,scale,scale);
		end
	end
end