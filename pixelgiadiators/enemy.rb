require "gosu";

class Enemy
	attr_accessor :x,:y,:w,:h,:dmg,:hp,:range
	def initialize x,y
		@x = x
		@y = y
		@w = 8.0;
		@h = 8.0;
		@speed = 0.01;
		@vx = 0.0;
		@vy = 0.0;
		@range = 5.0;
		@view_range = 20.0;
		@fallowing_player = false;
		@attack_speed = 1000.0;
		@can_attack = false;
		@attack_timer = 0.0;
		@dmg = 0.1
		@hp = 10.0;
		@animation_frame = 5;
		@actual_frame = 1;
		@animation_time = 300.0;
		@animation_timer = 0.0;
	end
	def update(delta,player)
		
		if(!@can_attack)
			@attack_timer += delta;
		end
		if(@attack_timer > @attack_speed)
			@attack_timer = 0.0;
			@can_attack = true;
		end

		if(@fallowing_player)
			if(player.x > @x) 
				@vx = @speed;
			elsif(player.x < @x) 
				@vx = -@speed;
			else 
				@vx = 0.0;
			end
			if(player.y >@y) 
				@vy = @speed;
			elsif(player.y <@y)
			 @vy = -@speed;
			else 
				@vy = 0.0;
			end
		else
			@vx = 0.0;
			@vy = 0.0;
		end
		@x += @vx * delta;
		@y += @vy * delta;
	end
	def player_detection(box)
		cx = @x + @w/2;
  		cy = @y + @h/2;
  		closeX = cx;
  		closeY = cy;
    if cx < box.x 
      closeX = box.x;
    end
    if cx > box.x + box.w 
      closeX = box.x + box.w;
    end
    if cy < box.y 
      closeY = box.y;
    end
    if cy > box.y + box.h
      closeY = box.y + box.h;
    end

    dis = Math.sqrt((closeX -cx)*(closeX - cx) + (closeY - cy)*(closeY - cy));

    if dis < @view_range 
    	@fallowing_player = true;
        return true;
    else
    	@fallowing_player = false;
        return false;
    end
	end

	def player_attacking(player)
	if(@can_attack)
		cx = @x + @w/2;
  		cy = @y + @h/2;
  		closeX = cx;
  		closeY = cy;
    if cx < player.x 
      closeX = player.x;
    end
    if cx > player.x + player.w 
      closeX = player.x + player.w;
    end
    if cy < player.y 
      closeY = player.y;
    end
    if cy > player.y + player.h
      closeY = player.y + player.h;
    end

    dis = Math.sqrt((closeX -cx)*(closeX - cx) + (closeY - cy)*(closeY - cy));

    if dis < @range 
    	@can_attack = false
   		player.hp -=@dmg;
        return true;
    else
        return false;
    	end
			end
	end

	def draw(scale)
		Gosu.draw_rect(@x*scale,@y*scale,@w*scale,@h*scale,0xff_ff0000);
	end
end
