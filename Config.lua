local Config = {}
Config.__index = Config

function Config.new()
    local self = {}

    self.GRID_WIDTH = 100
    self.GRID_HEIGHT = 100

    self.MIN_NODE_WIDTH = 10
    self.MIN_NODE_HEIGHT = 10
    self.MIN_RATIO = 0.35
    self.MAX_RATIO = 0.65

    self.MIN_NODES = 15

    self.COEFF_CONSTANT = -(1/100)
    self.EXP_CONSTANT = 2

    return setmetatable(self, Config)
end

return Config