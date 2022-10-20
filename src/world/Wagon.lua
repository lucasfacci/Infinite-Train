Wagon = Class{}

function Wagon:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.tiles = {}
    self:generateWallsAndFloors()

    self.player = player

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y
end

function Wagon:generateWallsAndFloors()
    for y = 1, self.height do
        table.insert(self.tiles, {})

        for x = 1, self.width do
            local id = TILE_EMPTY

            id = TILE_FLOOR

            table.insert(self.tiles[y], {
                id = id
            })
        end
    end
end

function Wagon:update(dt)
    self.player:update(dt)
end

function Wagon:render()
    for y = 1, self.height do
        for x = 1, self.width do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile.id],
                (x - 1) * TILE_SIZE + self.renderOffsetX,
                (y - 1) * TILE_SIZE + self.renderOffsetY)
        end
    end

    if self.player then
        self.player:render()
    end
end