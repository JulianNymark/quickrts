require "game"

Unit = Class{ __includes = Selectable }

function Unit:init( x, y, id )
	self.loc = Vec(x,y)
	self.id = id
	self.radius = units[self.id].radius
	self.speed = units[self.id].speed
	self.destination = nil
	self.direction = Vec(0,1) -- south
end

function Unit:draw()
	gr.setColor(100,100,100,255)
	gr.circle("fill", self.loc.x, self.loc.y, self.radius, 10)
end

function Unit:draw_selection()
	gr.setLine(1, "smooth")
	gr.setColor(255,255,255,255)
	gr.circle("line", self.loc.x, self.loc.y, self.radius + 5, 10)
end

function Unit:update( dt )
	if self.destination then
		self.direction = self.destination - self.loc
		self.direction = self.direction:normalized()
		self.loc = self.loc + (self.direction*self.speed)*dt
		
		if self.loc:dist(self.destination) < 1 then
			self.destination = nil
		end
	end
end
