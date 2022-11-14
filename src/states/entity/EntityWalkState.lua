EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity)
    self.entity = entity
    self.entity:changeAnimation('walk-' .. self.entity.direction)

    self.bumped = false
end

function EntityWalkState:update(dt)
    self.bumped = false

    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt

        if self.entity.x <= MAP_RENDER_OFFSET_X + 2 then
            -- if collides the left door
            if self.entity.y >= (5.7 * TILE_SIZE) and self.entity.y <= (8.5 * TILE_SIZE) then
                if self.entity.x <= 0 + 6 then
                    self.entity.x = 0 + 6
                    self.bumped = true
                end
            -- if collides the left wall
            else
                self.entity.x = MAP_RENDER_OFFSET_X + 2
                self.bumped = true
            end
        end
    elseif self.entity.direction == 'right' then
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        if self.entity.x + self.entity.width >= VIRTUAL_WIDTH - MAP_RENDER_OFFSET_X - 2 then
            -- if collides the right door
            if self.entity.y >= (5.7 * TILE_SIZE) and self.entity.y <= (8.5 * TILE_SIZE) then
                if self.entity.x >= VIRTUAL_WIDTH - self.entity.width - 6 then
                    self.entity.x = VIRTUAL_WIDTH - self.entity.width - 6
                    self.bumped = true
                end
            -- if collides the right wall
            else
                self.entity.x = VIRTUAL_WIDTH - MAP_RENDER_OFFSET_X - self.entity.width - 2
                self.bumped = true
            end
        end
    elseif self.entity.direction == 'up' then
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt
        -- if is in the left or right door
        if self.entity.x <= MAP_RENDER_OFFSET_X or
        self.entity.x + self.entity.width >= VIRTUAL_WIDTH - MAP_RENDER_OFFSET_X - 1 then
            -- if collides the top wall of the right or left door
                if self.entity.y <= 5.8 * TILE_SIZE then
                self.entity.y = 5.8 * TILE_SIZE
                self.bumped = true
            end
        end
        -- if collides the top wall
        if self.entity.y + self.entity.height <= MAP_RENDER_OFFSET_Y + TILE_SIZE * 5 - (TILE_SIZE / 2) then
            self.entity.y = (MAP_RENDER_OFFSET_Y + TILE_SIZE * 5) - (self.entity.height + TILE_SIZE / 2)
            self.bumped = true
        end
    elseif self.entity.direction == 'down' then
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt
        -- if is in the left or right door
        if self.entity.x <= MAP_RENDER_OFFSET_X or
        self.entity.x + self.entity.width >= VIRTUAL_WIDTH - MAP_RENDER_OFFSET_X - 1 then
            -- if collides the bottom wall of the right or left door
            if self.entity.y >= 8.4 * TILE_SIZE then
                self.entity.y = 8.4 * TILE_SIZE
                self.bumped = true
            end
        end
        -- if collides the bottom wall
        if self.entity.y + self.entity.height >= VIRTUAL_HEIGHT - MAP_RENDER_OFFSET_Y + (MAP_RENDER_OFFSET_Y / 4) then
            self.entity.y = VIRTUAL_HEIGHT - MAP_RENDER_OFFSET_Y + (MAP_RENDER_OFFSET_Y / 4) - self.entity.height
        end
    end
end

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
end