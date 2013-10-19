Player = Class{}

function Player:init ()
	self.units = {}
	self.structures = {}
	self.selected = {}
	self.supply = 0
	self.resources = { wood=0, stone=0, food=0, gold=0, metal=0 }
	self.score = 0
end

function Player:update ( dt )
	self.score = #self.units + #self.structures + self.supply +
		(utils.sum(self.resources) / 50)
end
