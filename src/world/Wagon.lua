Wagon = Class{}

function Wagon:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.tiles = {}
    self.tilesLayer = {}
    self:generateWallsAndFloors()

    self.backgroundScroll = 0

    self.player = player

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y
end

function Wagon:generateWallsAndFloors()
    local tileFloor = TILE_FLOORS[math.random(#TILE_FLOORS)]
    local tileTopWall = TILE_TOP_WALLS[math.random(#TILE_TOP_WALLS)]

    for y = 1, self.height do
        table.insert(self.tiles, {})
        table.insert(self.tilesLayer, {})

        for x = 1, self.width do
            local id = TILE_EMPTY
            local idLayer = TILE_EMPTY

            if y >= 1 and y <= 4 then
                if (y == 2 or y == 3) then
                    if (x >= 3 and x <= 4) or
                        (x >= 6 and x <= 7) or
                        (x >= 9 and x <= 10) or
                        (x >= 12 and x <= 13) or
                        (x >= 15 and x <= 16) or
                        (x >= 18 and x <= 19) or
                        (x >= 21 and x <= 22) then
                        id = TILE_GLASS
                    else
                        id = tileTopWall
                    end
                elseif y == 4 then
                    id = TILE_TOP_WALL_BOTTOM
                else
                    id = tileTopWall
                end
            else
                id = tileFloor
            end

            if y == 1 and x == 1 then
                idLayer = DELIMITER_TOP_LEFT_CORNER
            elseif y == 1 and x == self.width then
                idLayer = DELIMITER_TOP_RIGHT_CORNER
            elseif y == self.height and x == 1 then
                idLayer = DELIMITER_BOTTOM_LEFT_CORNER
            elseif y == self.height and x == self.width then
                idLayer = DELIMITER_BOTTOM_RIGHT_CORNER
            elseif y == 1 then
                idLayer = DELIMITER_TOP
            elseif x == 1 then
                idLayer = DELIMITER_LEFT
            elseif x == self.width then
                idLayer = DELIMITER_RIGHT
            elseif y == self.height then
                idLayer = DELIMITER_BOTTOM
            end

            table.insert(self.tiles[y], {
                id = id
            })

            table.insert(self.tilesLayer[y], {
                id = idLayer
            })
        end

    end
end

function Wagon:update(dt)
    self.player:update(dt)

    self.backgroundScroll = (self.backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
end

function Wagon:render()
    love.graphics.stencil(function()
        -- left
        love.graphics.rectangle('fill', 0, TILE_SIZE, self.renderOffsetX, TILE_SIZE * 5)

        -- right
        love.graphics.rectangle('fill', VIRTUAL_WIDTH - self.renderOffsetX, TILE_SIZE, self.renderOffsetX, TILE_SIZE * 5)
    end, 'replace', 1)

    love.graphics.setStencilTest('less', 1)

    for y = 1, self.height do
        for x = 1, self.width do
            -- Render the background
            if x == 1 and y == 1 then
                love.graphics.draw(gTextures['background'],
                -self.backgroundScroll,
                (y - 1) * TILE_SIZE + self.renderOffsetY)
            end
            -- Render the tiles
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile.id],
                (x - 1) * TILE_SIZE + self.renderOffsetX,
                (y - 1) * TILE_SIZE + self.renderOffsetY)
            -- Render the tiles that are one layer above
            local tileLayer = self.tilesLayer[y][x]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tileLayer.id],
                (x - 1) * TILE_SIZE + self.renderOffsetX,
                (y - 1) * TILE_SIZE + self.renderOffsetY)
        end
    end

    if self.player then
        self.player:render()
    end

    love.graphics.setStencilTest()
end