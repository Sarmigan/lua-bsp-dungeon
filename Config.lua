local Config = {}
Config.__index = Config

function Config.new()
    local self = {}

    self.GRID_WIDTH = 50
    self.GRID_HEIGHT = 50

    self.MAX_SPLIT_OFFSET = 2
    self.WALL_SPACING = 2
    self.MIN_NODE_WIDTH = 15
    self.MIN_NODE_HEIGHT = 15
    self.MIN_WIDTH = self.MAX_SPLIT_OFFSET + self.WALL_SPACING + self.MIN_NODE_WIDTH
    self.MIN_HEIGHT = self.MAX_SPLIT_OFFSET + self.WALL_SPACING + self.MIN_NODE_HEIGHT
    self.MAX_WIDTH = 25
    self.MAX_HEIGHT = 25
    
    self.CONSTANT = -(15/50)

    return setmetatable(self, Config)
end

return Config