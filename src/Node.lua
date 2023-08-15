local Node = {}
Node.__index = Node

function Node.new(pos1, pos2, rpos1, rpos2, lnode, rnode)
    local self = {}

    self.pos = {pos1, pos2}

    self.room = {
        pos = {rpos1, rpos2}
    }

    self.lnode = lnode

    self.rnode = rnode

    return setmetatable(self, Node)
end

function Node:splitNode(min_width, min_height, min_ratio, max_ratio)
    local splitX = math.random(self.pos[1][1] + min_width, self.pos[2][1] - min_width)
    local splitY = math.random(self.pos[1][2] + min_height, self.pos[2][2] - min_height)
    
    local width = self.pos[2][1] - self.pos[1][1]
    local height = self.pos[2][2] - self.pos[1][2]

    if width > height then
        if (splitX-self.pos[1][1])/height < max_ratio and (splitX-self.pos[1][1])/height > min_ratio then
            self.lnode = Node.new(self.pos[1], {splitX-1, self.pos[2][2]})
            self.rnode = Node.new({splitX+1, self.pos[1][2]}, self.pos[2])
        else
            return self:splitNode(min_width, min_height, min_ratio, max_ratio)
        end
    else
        if (splitY-self.pos[1][2])/width < max_ratio and (splitY-self.pos[1][2])/width > min_ratio then
            self.lnode = Node.new(self.pos[1], {self.pos[2][1], splitY-1})
            self.rnode = Node.new({self.pos[1][1], splitY+1}, self.pos[2])
        else
            return self:splitNode(min_width, min_height, min_ratio, max_ratio)
        end
    end
end

return Node