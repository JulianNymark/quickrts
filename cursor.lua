Cursor = Class{}

-- Constructor
function Cursor:init()
	-- load cursor images
	self.imgs = utils.img_load_dir("assets/cursor")
	self.select_img = "normal"
	self.mode = "normal"
end

function Cursor:draw ()
	gr.setColor(255,255,255,255)
	gr.draw(self.imgs[self.select_img], ms.getX(), ms.getY())
end
