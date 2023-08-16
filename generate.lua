local Node = require "src/Node"
local Grid = require "src/Grid"
local Config = require "Config"
local config = Config.new()

function split(parent, layer)
    local width = parent.pos[2][1] - parent.pos[1][1]
    local height = parent.pos[2][2] - parent.pos[1][2]

    if width/2 < config.MIN_NODE_WIDTH or height/2 < config.MIN_NODE_HEIGHT then
        return
    end
    
    if math.random() <= 2.718281828459045^(config.COEFF_CONSTANT*(layer^config.EXP_CONSTANT)) then
        parent:splitNode(config.MIN_NODE_WIDTH, config.MIN_NODE_HEIGHT, config.MIN_RATIO, config.MAX_RATIO)
        split(parent.lnode, layer+1)
        split(parent.rnode, layer+1)
    end
end

function findLeaf(node, leafNodes)
    if node == nil then
        return
    end

    if node.lnode == nil and node.rnode == nil then
        table.insert(leafNodes, node)
    end

    findLeaf(node.lnode, leafNodes)
    findLeaf(node.rnode, leafNodes)
end

function display(grid, nodes)
    for index,node in ipairs(nodes) do
        for j = node.pos[1][2],node.pos[2][2] do
            for i = node.pos[1][1],node.pos[2][1] do
                grid.map[i][j] = index
            end
        end
    end

    grid:display()
end

function wait()
    local answer = nil
    repeat
        io.write("continue?")
        io.flush()
        answer=io.read()
    until answer ~= nil
end

local leafNodes = {}
local root = nil
while #leafNodes < config.MIN_NODES do
    leafNodes = {}
    root = Node.new({1, 1}, {config.GRID_WIDTH, config.GRID_HEIGHT})
    split(root, 0)
    findLeaf(root, leafNodes)
end

local rooms = {}
while #leafNodes > 0 do
    table.insert(rooms, table.remove(leafNodes, math.random(1, #leafNodes)))
end

local grid = Grid.new(config.GRID_WIDTH, config.GRID_HEIGHT)
display(grid, rooms)
