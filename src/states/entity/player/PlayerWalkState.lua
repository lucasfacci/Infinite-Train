PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player)
    self.entity = player

    self.entity.offsetX = 0
    self.entity.offsetY = 0
end

function PlayerWalkState:update(dt)
    -- assume we didn't hit a wall
    self.bumped = false

    -- walk diagonally to the top left side
    if love.keyboard.isDown('a') and love.keyboard.isDown('w') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-left')
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt
    -- walk diagonally to the bottom left side
    elseif love.keyboard.isDown('a') and love.keyboard.isDown('s') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-left')
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
    -- walk straight to the left side
    elseif love.keyboard.isDown('a') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-left')
        
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
    -- walk diagonally to the top right side
    elseif love.keyboard.isDown('d') and love.keyboard.isDown('w') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-right')

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt
    -- walk diagonally to the bottom right side
    elseif love.keyboard.isDown('d') and love.keyboard.isDown('s') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-right')

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
    -- walk straight to the right side
    elseif love.keyboard.isDown('d') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-right')

        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
    -- walk straight to the top side
    elseif love.keyboard.isDown('w') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('walk-up')

        self.entity.y = self.entity.y - self.entity.walkSpeed * dt
    -- walk straight to the bottom side
    elseif love.keyboard.isDown('s') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('walk-down')

        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
    -- don't walk, stay idle
    else
        self.entity:changeState('idle')
    end

    -- if collides a left wall
    if self.entity.x <= MAP_RENDER_OFFSET_X + 8 then
        -- if collides the left door
        if self.entity.y >= (5.4 * TILE_SIZE) and self.entity.y <= (8.4 * TILE_SIZE) then
            if self.entity.x <= 12 and self.entity.direction == 'left' then
                self.bumped = true
                gStateStack:push(FadeInState({
                    r = 0, g = 0, b = 0,
                }, 1,
                function()
                    gStateStack:push(PlayState({
                        direction = 'left',
                        x = VIRTUAL_WIDTH - self.entity.width - 12,
                        y = self.entity.y
                    }))
                    gStateStack:push(FadeOutState({
                        r = 0, g = 0, b = 0,
                    }, 1,
                    function()
                    end))
                end))
            end
        -- if collides the left wall
        else
            self.entity.x = MAP_RENDER_OFFSET_X + 8
            self.bumped = true
        end
    end

    -- if collides a right wall
    if self.entity.x + self.entity.width >= VIRTUAL_WIDTH - MAP_RENDER_OFFSET_X - 8 then
        -- if collides the right door
        if self.entity.y >= (5.4 * TILE_SIZE) and self.entity.y <= (8.4 * TILE_SIZE) then
            if self.entity.x >= VIRTUAL_WIDTH - self.entity.width - 12 and self.entity.direction == 'right' then
                self.bumped = true
                gStateStack:push(FadeInState({
                    r = 0, g = 0, b = 0,
                }, 1,
                function()
                    gStateStack:push(PlayState({
                        direction = 'right',
                        x = 12,
                        y = self.entity.y
                    }))
                    gStateStack:push(FadeOutState({
                        r = 0, g = 0, b = 0,
                    }, 1,
                    function()
                    end))
                end))
            end
        -- if collides the right wall
        else
            self.entity.x = VIRTUAL_WIDTH - MAP_RENDER_OFFSET_X - self.entity.width - 8
            self.bumped = true
        end
    end

    -- if is in the left or right door
    if self.entity.x <= MAP_RENDER_OFFSET_X or
    self.entity.x + self.entity.width >= VIRTUAL_WIDTH - MAP_RENDER_OFFSET_X - 1 then
        -- if collides the top wall of the right or left door
        if self.entity.y <= 5.5 * TILE_SIZE then
            self.entity.y = 5.5 * TILE_SIZE
            self.bumped = true
        end
        -- if collides the bottom wall of the right or left door
        if self.entity.y >= 8.3 * TILE_SIZE then
            self.entity.y = 8.3 * TILE_SIZE
            self.bumped = true
        end
    end

    -- if collides the top wall
    if self.entity.y + self.entity.height <= MAP_RENDER_OFFSET_Y + TILE_SIZE * 4 + (TILE_SIZE / 4) then
        self.entity.y = (MAP_RENDER_OFFSET_Y + TILE_SIZE * 4) - (self.entity.height - TILE_SIZE / 4)
        self.bumped = true
    end

    -- if collides the bottom wall
    if self.entity.y + self.entity.height >= VIRTUAL_HEIGHT - MAP_RENDER_OFFSET_Y then
        self.entity.y = VIRTUAL_HEIGHT - MAP_RENDER_OFFSET_Y - self.entity.height
    end

    EntityWalkState.update(self, dt)
end