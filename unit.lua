Unit = Class{ __includes = Selectable }

function Unit:init( x, y , id )
	self.x = x
	self.y = y
	self.id = id
end

function Unit:draw()
	gr.setColor(100,100,100,255)
	gr.circle("fill", self.x, self.y, units[self.id].radius, 10)
end

function Unit:draw_selection()
	gr.setColor(255,255,255,255)
	gr.circle("line", self.x, self.y, units[self.id].radius + 5, 10)
end
