game = {}

function game.init ()
	if ms.isVisible() then
		ms.setVisible(false)
	end
	
	players = {}
	players["p1"] = Player()
	players["ai1"] = Player()
	
	c = Cursor()
	mouse_timer = 0
	mouse_prev_loc = nil
	
	units = {} -- don't confuse with player's units! this is unit info
	units["test"] = { radius = 10, speed = 50, health = 10, armor = 0}
end

function game.draw ()
	-- clear screen
	gr.setBackgroundColor(20,20,20)
	gr.clear()
	
	-- draw selection circles
	for i,p in pairs(players) do
		for i2,u in pairs(p.selected) do
			u:draw_selection()
		end
	end
	
	-- draw units
	for i,p in pairs(players) do
		for i2,u in pairs(p.units) do
			u:draw()
		end
	end
	
	-- draw selection box
	if c.mode == "select_box" then
		gr.setLine(1, "rough")
		gr.setColor(255,255,255,255)
		gr.rectangle("line", mouse_prev_loc.x, mouse_prev_loc.y, 
					 ms.getX() - mouse_prev_loc.x, 
					 ms.getY() - mouse_prev_loc.y)
	end
	c:draw() -- draw cursor last
end

function game.update ( dt )
	local mouse_curr_loc = Vec( ms.getX(), ms.getY() )
	if ms.isDown("l") then
		if
			c.mode ~= "select_box"
			and mouse_prev_loc
			and	mouse_prev_loc:dist(mouse_curr_loc) > 2
		then
			c.mode = "select_box"
			c.select_img = "smaller"
		elseif
			c.mode ~= "single_click"
			and mouse_prev_loc
			and mouse_prev_loc:dist(mouse_curr_loc) <= 2
		then
			c.mode = "single_click"
		end
	end
	
	for i,p in pairs(players) do
		p:update( dt )
	end
end

function game.mousepressed ( x, y, button )
	if button == "l" then
		players.p1.selected = {}
	elseif button == "r" then
		local move_order = Vec(x, y)
		for i,u in pairs(players.p1.selected) do
			u.destination = move_order
		end
	end
	mouse_prev_loc = Vec( ms.getX(), ms.getY() )
end

function game.mousereleased ( x, y, button )
	if c.mode == "select_box" then
		for i,u in pairs(players.p1.units) do
			if u.loc.x < math.max(x, mouse_prev_loc.x) and 
				u.loc.x > math.min(x, mouse_prev_loc.x) and
				u.loc.y < math.max(y, mouse_prev_loc.y) and 
				u.loc.y > math.min(y, mouse_prev_loc.y)
			then
				table.insert(players.p1.selected, u)
			end
		end
	elseif c.mode == "single_click" then
		local click_vec = Vec(x, y)
		for i,u in pairs(players.p1.units) do
			if click_vec:dist(u.loc) < u.radius	then
				table.insert(players.p1.selected, u)
				break
			end
		end
	end
	
	c.mode = "normal"
	c.select_img = "normal"
end

function game.keypressed ( key )
	if key == "escape" then
		ev.push("quit")
	end
	if key == "a" then
		c.select_img = "red"
	end
	if key == " " then
		u = Unit(math.random(10,gr.getWidth()-10),
				 math.random(10,gr.getHeight()-10),
				 "test")
		table.insert(players.p1.units, u)
	end
end
