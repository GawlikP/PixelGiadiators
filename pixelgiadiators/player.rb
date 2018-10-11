require "gosu";
#require_relative "sprites";

class Player 
	attr_accessor :x, :y,:w,:h,:hp, :mp, :st, :money
	def initialize 
		@x = 0.0
		@y = 0.0
		@w = 8.0
		@h = 8.0
		@vx = 0.0
		@vy = 0.0
		@speed = 0.03
		@frames = 5;
		@act_frame = 1;
		@frame_time = 2000*@speed;
		@act_frame_time = 0;
		@turn = "right";
		@hp = 10.0;
		@mp = 10.0;
		@st = 0.0;
		@money = 0.0;
		@moving = false;
	end
	def moving 
		if Gosu.button_down? Gosu::KB_UP
			@vy = -@speed;
		elsif Gosu.button_down? Gosu::KB_DOWN
			@vy = @speed;
		else
			@vy = 0.0;
		end
		if Gosu.button_down? Gosu::KB_LEFT
			@vx = -@speed;
		elsif Gosu.button_down? Gosu::KB_RIGHT
			@vx = @speed;
		else
			@vx = 0.0;
		end
	end
	def collision(obj)
		 if (@x > obj.x + obj.w or @y > obj.y + obj.h or @x + @w < obj.x or @y + @h < obj.y)
		 	return false;
       else
           bx = obj.x + obj.w/2;
           by = obj.y + obj.h/2;
           px = @x + @w/2;
           py = @y + @h/2;

          dx = (px - bx).abs;
          dy = (py - by).abs;

                if (dx > dy)
                    if (px > bx) 
                    	@x = @x + (@w/2 + obj.w/2 - dx);
                    else
                      @x = @x - (@w/2 + obj.w/2 - dx);
                    end
              else
                   if (py > by)
                    @y = @y + (@h/2 + obj.h/2 - dy);
                  else
                    @y = @y - (@h/2 + obj.h/2 - dy);
                   end
              end
        end
	end
	def GoldCollision(obj) 
		if (@x > obj.x + obj.w or @y > obj.y + obj.h or @x + @w < obj.x or @y + @h < obj.y)
		 	return false;
		 else
		 	@money += obj.mout_of_gold;
		 	return true;
		 end	
	end
	def update(dt)
		@act_frame_time += dt;
		if(@act_frame_time > @frame_time) 
		@act_frame_time = 0;
		@act_frame+=1;
		end
		if(@act_frame > @frames) 
			@act_frame=1;
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
		@x += @vx * dt;
		@y += @vy * dt;
	end
	def draw(idle,walking1,walking2,walking3,walking4,scale)
		#Gosu.draw_rect(@x*scale, @y*scale, @w*scale, @h*scale, 0xff_ff0000);
			
			x = @x;
		if(@right)
			scale_x = scale;

		end
		if(!@right)
			scale_x = -scale;
			x=x+8
		end
		if(@moving)
		if(@act_frame==1) 
			idle.draw(x*scale,@y*scale,0,scale_x,scale); 
		end
		if(@act_frame==2)
		 walking1.draw(x*scale,@y*scale,0,scale_x,scale); 
		end
		if(@act_frame==3)
		 walking2.draw(x*scale,@y*scale,0,scale_x,scale); 
		end
		if(@act_frame==4)
		 walking3.draw(x*scale,@y*scale,0,scale_x,scale); 
		end
		if(@act_frame==5)
		 walking4.draw(x*scale,@y*scale,0,scale_x,scale); 
		end
		else
			idle.draw(x*scale,@y*scale,0,scale_x,scale); 
		end
	end
	def UI(font)
		font.draw("Player hp:#{@hp}",0,0,0,1,1,0xff_ff0000);
		font.draw("Player mp:#{@mp}",0,16,0,1,1,0xff_0000ff);
		font.draw("Player money:#{@money}",0,32,0,1,1,0xff_ffff00);
	end
end