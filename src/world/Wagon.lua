Wagon = Class{}

function Wagon:init(player, boss)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.backgroundScroll = 0

    self.lighter = Lighter()

    self.player = player
    self.boss = boss

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.tiles = {}
    self.tilesLayer = {}
    self:generateWagon()

    -- objects in the wagon
    self.objects = {}
    self:generatePassengersWagonObjects()

    Event.on('player-fire', function()
        self.player:fire(190, 190, 95, self.boss)
    end)

    Event.on('boss-fire', function()
        self.boss:fire(190, 190, 95, self.player)
    end)
end

function Wagon:generateWagon()
    for y = 1, self.height do
        table.insert(self.tiles, {})
        table.insert(self.tilesLayer, {})

        for x = 1, self.width do
            local id = TILE_EMPTY
            local idLayer = TILE_EMPTY

            -- generates walls and glasses
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
                        id = TILE_TOP_WALL
                    end
                elseif y == 4 then
                    id = TILE_TOP_WALL_BOTTOM
                else
                    id = TILE_TOP_WALL
                end
            else
                id = TILE_FLOOR
            end

            -- generates delimiters, sconces and lights
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
            elseif x == 1 and (y >= 4 and y <= 9) then
                idLayer = TILE_EMPTY
            elseif x == 1 then
                idLayer = DELIMITER_LEFT
            elseif x == self.width and (y >= 4 and y <= 9) then
                idLayer = TILE_EMPTY
            elseif x == self.width then
                idLayer = DELIMITER_RIGHT
            elseif y == self.height then
                idLayer = DELIMITER_BOTTOM
            elseif y == 2 and
                (x == 5 or x == 8 or x == 11 or x == 14 or x == 17 or x == 20) then
                idLayer = TILE_SCONCE
                self.lighter:addLight((x - 1) * TILE_SIZE + self.renderOffsetX + TILE_SIZE / 2,
                                    (y - 1) * TILE_SIZE + self.renderOffsetY + TILE_SIZE / 3,
                                    20, 56, 87, 71)
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

function Wagon:generatePassengersWagonObjects()
    for y = 1, 41, 7.75 do
        local chairTop = GameObject(GAME_OBJECT_DEFS['chair'], y * TILE_SIZE / 2 + self.renderOffsetX, 6 * TILE_SIZE / 2 + self.renderOffsetY)

        local chairBottom = GameObject(GAME_OBJECT_DEFS['chair'], y * TILE_SIZE / 2 + self.renderOffsetX, 18 * TILE_SIZE / 2 + self.renderOffsetY)
        
        chairTop.onCollide = function(this, entity)

            if chairTop.solid == true then
                
                if entity.direction == 'left' then
                    
                    -- if the entity is in the right side of the chair
                    if chairTop.entityNameAndSide[entity.type].side == 'right' and entity.y < chairTop.y + chairTop.height - entity.height + entity.height / 4 then
                        entity.x = chairTop.x + chairTop.width
                        entity.stateMachine.current.bumped = true
                    end
    
                    -- if the entity is in the bottom side of the chair
                    if chairTop.entityNameAndSide[entity.type].side == 'bottom' and entity.y <= chairTop.y + chairTop.height - entity.height + entity.height / 4 and entity.x + entity.width > chairTop.x and entity.x < chairTop.x + chairTop.width then
                        entity.y = chairTop.y + chairTop.height - entity.height + entity.height / 4
                        entity.stateMachine.current.bumped = true
                    end
    
                elseif entity.direction == 'right' then
    
                    -- if the entity is in the left side of the chair
                    if chairTop.entityNameAndSide[entity.type].side == 'left' and entity.y < chairTop.y + chairTop.height - entity.height + entity.height / 4 then
                        entity.x = chairTop.x - entity.width
                        entity.stateMachine.current.bumped = true
                    end
    
                    -- if the entity is in the bottom side of the chair
                    if chairTop.entityNameAndSide[entity.type].side == 'bottom' and entity.y <= chairTop.y + chairTop.height - entity.height + entity.height / 4 and entity.x + entity.width > chairTop.x and entity.x < chairTop.x + chairTop.width then
                        entity.y = chairTop.y + chairTop.height - entity.height + entity.height / 4
                        entity.stateMachine.current.bumped = true
                    end
    
                elseif entity.direction == 'up' then
                        
                    -- if the entity is in the bottom side of the chair
                    if entity.y <= chairTop.y + chairTop.height - entity.height + entity.height / 4 and entity.x + entity.width > chairTop.x and entity.x < chairTop.x + chairTop.width then
                        entity.y = chairTop.y + chairTop.height - entity.height + entity.height / 4
                        entity.stateMachine.current.bumped = true
                    end
    
                end
                
            end
        end
    
        chairBottom.onCollide = function(this, entity)
    
            if chairBottom.solid == true then
    
                if entity.direction == 'left' then
                    
                    -- if the entity is in the right side of the chair
                    if chairBottom.entityNameAndSide[entity.type].side == 'right' and entity.y < chairBottom.y + chairBottom.height - entity.height + entity.height / 4 then
                        entity.x = chairBottom.x + chairBottom.width
                        entity.stateMachine.current.bumped = true
                    end
    
                    -- if the entity is in the top side of the chair
                    if chairBottom.entityNameAndSide[entity.type].side == 'top' and entity.y + entity.height - entity.height / 3 >= chairBottom.y and entity.x + entity.width > chairBottom.x and entity.x < chairBottom.x + chairBottom.width then
                        entity.y = chairBottom.y - entity.height + entity.height / 3
                        entity.stateMachine.current.bumped = true
                    end
    
                elseif entity.direction == 'right' then
    
                    -- if the entity is in the left side of the chair
                    if chairBottom.entityNameAndSide[entity.type].side == 'left' and entity.y < chairBottom.y + chairBottom.height - entity.height + entity.height / 4 then
                        entity.x = chairBottom.x - entity.width
                        entity.stateMachine.current.bumped = true
                    end
    
                    -- if the entity is in the top side of the chair
                    if chairBottom.entityNameAndSide[entity.type].side == 'top' and entity.y + entity.height - entity.height / 3 >= chairBottom.y and entity.x + entity.width > chairBottom.x and entity.x < chairBottom.x + chairBottom.width then
                        entity.y = chairBottom.y - entity.height + entity.height / 3
                        entity.stateMachine.current.bumped = true
                    end
    
                elseif entity.direction == 'down' then
    
                    -- if the entity is in the top side of the chair
                    if entity.y + entity.height - entity.height / 3 >= chairBottom.y and entity.x + entity.width > chairBottom.x and entity.x < chairBottom.x + chairBottom.width then
                        entity.y = chairBottom.y - entity.height + entity.height / 3
                        entity.stateMachine.current.bumped = true
                    end
    
                end
                
            end
        end

        -- top
        table.insert(self.objects, chairTop)
        -- bottom
        table.insert(self.objects, chairBottom)
    end
end

function Wagon:update(dt)
    self.player:update(dt)

    if self.boss.health <= 0 then
        self.boss.dead = true
        gSounds['death']:play()
        if self.boss.luck == 1 then
            local heart = GameObject(GAME_OBJECT_DEFS['heart'], self.boss.x, self.boss.y)

            heart.onCollide = function(this, entity)
                entity:heal(1)
            end

            table.insert(self.objects, heart)
            self.boss.luck = 0
        end
    elseif not self.boss.dead then
        self.boss:processAI({wagon = self}, dt)
        self.boss:update(dt)
    end

    self.backgroundScroll = (self.backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

    for k, object in pairs(self.objects) do
        -- trigger collision callback on object
        if self.player:collides(object) then
            object:onCollide(self.player)
            if object.type == 'heart' then
                gSounds['heal']:play()
                table.remove(self.objects, k)
            end
        end

        if self.boss:collides(object) then
            object:onCollide(self.boss)
        end
    end
end

function Wagon:render()
    for y = 1, self.height do
        for x = 1, self.width do
            -- Render the background
            if x == 1 and y == 1 then
                love.graphics.draw(gTextures['background'], gFrames['background'][1],
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

    love.graphics.setColor(0, 0, 0, 100)

    -- left
    love.graphics.rectangle('fill', 0, self.renderOffsetY, self.renderOffsetX, TILE_SIZE * 4)

    -- right
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - self.renderOffsetX, self.renderOffsetY, self.renderOffsetX, TILE_SIZE * 4)

    love.graphics.setColor(255, 255, 255, 255)

    -- LEFT DOOR
    -- door walls
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_TOP_WALL],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE - TILE_SIZE / 2,
        5 * TILE_SIZE / 2 + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_TOP_WALL],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE - TILE_SIZE / 2,
        7 * TILE_SIZE / 2 + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_TOP_WALL],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE - TILE_SIZE / 2,
        9 * TILE_SIZE / 2 + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_TOP_WALL_BOTTOM],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE - TILE_SIZE / 2,
        11 * TILE_SIZE / 2 + self.renderOffsetY)
    -- door floors
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_FLOOR],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE - TILE_SIZE / 2,
        13 * TILE_SIZE / 2 + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_FLOOR],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE - TILE_SIZE / 2,
        15 * TILE_SIZE / 2 + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_FLOOR],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE - TILE_SIZE / 2,
        17 * TILE_SIZE / 2 + self.renderOffsetY)
    -- door top left corner border
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_TOP_LEFT_CORNER],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE * 2,
        5 * TILE_SIZE / 2 + self.renderOffsetY)
    -- door top right corner border
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_BOTTOM_RIGHT_CORNER],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE - TILE_SIZE / 2,
        2 * TILE_SIZE + self.renderOffsetY)
    -- door middle borders
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_LEFT],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE * 2,
        3 * TILE_SIZE + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_LEFT],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE * 2,
        4 * TILE_SIZE + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_LEFT],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE * 2,
        5 * TILE_SIZE + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_LEFT],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE * 2,
        6 * TILE_SIZE + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_LEFT],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE * 2,
        7 * TILE_SIZE + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_LEFT],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE * 2,
        8 * TILE_SIZE + self.renderOffsetY)
    -- door bottom left corner boder
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_BOTTOM_LEFT_CORNER],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE * 2,
        17 * TILE_SIZE / 2 + self.renderOffsetY)
    -- door bottom right corner border
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_TOP_RIGHT_CORNER],
        TILE_SIZE + self.renderOffsetX - TILE_SIZE - TILE_SIZE / 2,
        9 * TILE_SIZE + self.renderOffsetY)

    -- RIGHT DOOR
    -- door walls
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_TOP_WALL],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX - TILE_SIZE / 2,
        5 * TILE_SIZE / 2 + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_TOP_WALL],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX - TILE_SIZE / 2,
        7 * TILE_SIZE / 2 + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_TOP_WALL],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX - TILE_SIZE / 2,
        9 * TILE_SIZE / 2 + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_TOP_WALL_BOTTOM],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX - TILE_SIZE / 2,
        11 * TILE_SIZE / 2 + self.renderOffsetY)
    -- door floors
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_FLOOR],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX - TILE_SIZE / 2,
        13 * TILE_SIZE / 2 + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_FLOOR],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX - TILE_SIZE / 2,
        15 * TILE_SIZE / 2 + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][TILE_FLOOR],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX - TILE_SIZE / 2,
        17 * TILE_SIZE / 2 + self.renderOffsetY)
    -- door top left corner border
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_BOTTOM_LEFT_CORNER],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX - TILE_SIZE / 2,
        2 * TILE_SIZE + self.renderOffsetY)
    -- door top right corner border
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_TOP_RIGHT_CORNER],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX,
        5 * TILE_SIZE / 2 + self.renderOffsetY)
    -- door middle borders
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_RIGHT],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX,
        3 * TILE_SIZE + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_RIGHT],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX,
        4 * TILE_SIZE + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_RIGHT],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX,
        5 * TILE_SIZE + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_RIGHT],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX,
        6 * TILE_SIZE + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_RIGHT],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX,
        7 * TILE_SIZE + self.renderOffsetY)
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_RIGHT],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX,
        8 * TILE_SIZE + self.renderOffsetY)
    -- door bottom left corder border
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_TOP_LEFT_CORNER],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX - TILE_SIZE / 2,
        9 * TILE_SIZE + self.renderOffsetY)
    -- door bottom right corder border
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][DELIMITER_BOTTOM_RIGHT_CORNER],
        MAP_WIDTH * TILE_SIZE + self.renderOffsetX,
        17 * TILE_SIZE / 2 + self.renderOffsetY)

    love.graphics.stencil(function()
        -- bottom left door
        love.graphics.rectangle('fill', TILE_SIZE + self.renderOffsetX - TILE_SIZE - TILE_SIZE / 2, 9 * TILE_SIZE + self.renderOffsetY, TILE_SIZE, TILE_SIZE)
        -- bottom right door
        love.graphics.rectangle('fill', MAP_WIDTH * TILE_SIZE + self.renderOffsetX - TILE_SIZE / 2, 9 * TILE_SIZE + self.renderOffsetY, TILE_SIZE, TILE_SIZE)
        -- bottom
        love.graphics.rectangle('fill', 0, VIRTUAL_HEIGHT - self.renderOffsetY - TILE_SIZE / 2, VIRTUAL_WIDTH, self.renderOffsetY + TILE_SIZE)
    end, 'replace', 1)

    love.graphics.setStencilTest('less', 1)

    for k, object in pairs(self.objects) do
        object:render()
    end

    love.graphics.stencil(function()
        for y = 1, 41, 7.75 do
            -- chairs bottom backrest
            love.graphics.rectangle('fill', y * TILE_SIZE / 2 + self.renderOffsetX, 18 * TILE_SIZE / 2 + self.renderOffsetY, 5, 10)
            -- chairs bottom arm
            love.graphics.rectangle('fill', y * TILE_SIZE / 2 + self.renderOffsetX + 5, 18 * TILE_SIZE / 2 + self.renderOffsetY + 3, 27, 45)
        end
    end, 'replace', 1, true)

    if self.player then
        self.player:render()
    end

    if not self.boss.dead then
        self.boss:render()
    end

    love.graphics.setStencilTest()

    self.lighter:drawLights()

    --
    -- DEBUG DRAWING OF STENCIL RECTANGLES
    --

    -- love.graphics.setColor(0, 255, 0, 100)

    -- -- bottom
    -- love.graphics.rectangle('fill', 0, VIRTUAL_HEIGHT - self.renderOffsetY - TILE_SIZE / 2, VIRTUAL_WIDTH, self.renderOffsetY + TILE_SIZE)

    -- love.graphics.setColor(255, 255, 255, 255)
end