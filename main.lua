local Node = require "src/Node"
local Grid = require "src/Grid"
local Config = require "Config"
local config = Config.new()

local function split(parent, layer)
    local direction = nil
    local width = parent.pos[2][1] - parent.pos[1][1]
    local height = parent.pos[2][2] - parent.pos[1][2]

    if width < config.MIN_WIDTH and height < config.MIN_HEIGHT then
        return
    elseif width > config.MIN_WIDTH and height < config.MIN_HEIGHT then
        direction = 0
    elseif height > config.MIN_HEIGHT and width < config.MIN_WIDTH then
        direction = 1
    end

    if height > config.MAX_HEIGHT and width > config.MAX_WIDTH then
        parent:splitNode(config.MAX_SPLIT_OFFSET, direction)
        split(parent.lnode, layer+1)
        split(parent.rnode, layer+1)
    elseif width > config.MAX_WIDTH then
        parent:splitNode(config.MAX_SPLIT_OFFSET, 0)
        split(parent.lnode, layer+1)
        split(parent.rnode, layer+1)
    elseif height > config.MAX_HEIGHT then
        parent:splitNode(config.MAX_SPLIT_OFFSET, 1)
        split(parent.lnode, layer+1)
        split(parent.rnode, layer+1)
    elseif math.random() < 2.718281828459045^(config.CONSTANT*layer) then
        parent:splitNode(config.MAX_SPLIT_OFFSET, direction)
        split(parent.lnode, layer+1)
        split(parent.rnode, layer+1)
    end
end

local function findLeaf(node, leafNodes)
    if node == nil then
        return
    end

    if node.lnode == nil and node.rnode == nil then
        table.insert(leafNodes, node)
    end

    findLeaf(node.lnode, leafNodes)
    findLeaf(node.rnode, leafNodes)
end

local grid = Grid.new(config.GRID_WIDTH, config.GRID_HEIGHT)
local root = Node.new({1, 1}, {config.GRID_WIDTH, config.GRID_HEIGHT})
local leafNodes = {}

split(root, 0)
findLeaf(root, leafNodes)

for _,node in ipairs(leafNodes) do
    for j = node.pos[1][2],node.pos[2][2] do
        for i = node.pos[1][1],node.pos[2][1] do
            grid.map[i][j] = _
        end
    end
end

grid:display()