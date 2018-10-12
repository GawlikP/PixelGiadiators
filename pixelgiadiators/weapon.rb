class Weapon
	attr_accessor :name, :dmg, :attack_speed, :range
	def initialize(name,dmg,attack_speed,range);
		@name = name;
		@dmg = dmg;
		@attack_speed = attack_speed;
		@range = range;
	end
end