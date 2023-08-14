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

function Node:splitNode(split_offset, direction)
    local splitX = math.random(math.floor((self.pos[1][1] + self.pos[2][1])/2 - split_offset), math.floor((self.pos[1][1] + self.pos[2][1])/2 + split_offset))
    local splitY = math.random(math.floor((self.pos[1][2] + self.pos[2][2])/2 - split_offset), math.floor((self.pos[1][2] + self.pos[2][2])/2 + split_offset))

    print(direction)

    if direction == nil then
        direction = math.random(2)
    end

    if direction == 0 then
        self.lnode = Node.new(self.pos[1], {splitX-1, self.pos[2][2]})
        self.rnode = Node.new({splitX+1, self.pos[1][2]}, self.pos[2])
    else
        self.lnode = Node.new(self.pos[1], {self.pos[2][1], splitY-1})
        self.rnode = Node.new({self.pos[1][1], splitY+1}, self.pos[2])
    end
end

return Node