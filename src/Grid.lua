local Grid = {}
Grid.__index = Grid

function Grid.new(width, height)
    local self = {}

    self.map = {}

    for j = 1,height do
        local row = {}
        for i = 1,width do
            row[i] = 0
        end
        self.map[j] = row
    end

    return setmetatable(self, Grid)
end

function Grid:display()
    local colors = {
        "\27[31m",
        "\27[32m",
        "\27[33m",
        "\27[34m",
        "\27[35m",
        "\27[36m"
    }

    for j = 1,#self.map do
        for i = 1,#self.map[j] do
            if self.map[i][j] == 0 then
                io.write("\27[37m# ")
            else
                io.write(colors[(self.map[i][j] - 1) % #colors + 1].."# ")
            end
        end
        io.write("\n")
    end
    print("\27[0m")
end

return Grid