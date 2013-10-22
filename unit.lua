require "game"

Unit = Class{ __includes = Selectable }

function Unit:init( x, y, id )
	self.loc = Vec(x,y)
	self.id = id
	self.radius = units[self.id].radius
	self.speed = units[self.id].speed
	self.destination = nil
	self.dir = Vec(0,1) -- south
end

function Unit:draw()
	gr.setColor(255,255,255,255)
	local angle = math.atan2(self.dir.y, self.dir.x)
	local angle = angle*(180/math.pi)
	local dir_img = nil
	
	if angle <= -157.5 then
		dir_img = "west"
	elseif angle <= -112.5 then
		dir_img = "northwest"
	elseif angle <= -67.5 then
		dir_img = "north"
	elseif angle <= -22.5 then
		dir_img = "northeast"
	elseif angle <= 22.5 then
		dir_img = "east"
	elseif angle <= 67.5 then
		dir_img = "southeast"
	elseif angle <= 112.5 then
		dir_img = "south"
	elseif angle <= 157.5 then
		dir_img = "southwest"
	else
		dir_img = "west"
	end
	-- add potential offsets to x and y here, based on size off sprite
	gr.draw(units_img[self.id][dir_img], self.loc.x - 16, self.loc.y - 16)	
end

function Unit:draw_selection()
	gr.setLine(1, "smooth")
	gr.setColor(255,255,255,255)
	gr.circle("line", self.loc.x, self.loc.y, self.radius + 5, 10)
end

function Unit:update( dt )
	if self.destination then
		self.dir = self.destination - self.loc
		self.dir = self.dir:normalized()
		self.loc = self.loc + (self.dir*self.speed)*dt
		
		if self.loc:dist(self.destination) < 1 then
			self.destination = nil
		end
	end
end
