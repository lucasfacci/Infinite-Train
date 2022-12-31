EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity)
    self.entity = entity
    self.entity:changeAnimation('walk-' .. self.entity.direction)

    self.bumped = false
end

function EntityWalkState:update(dt)
    -- assume we didn't hit a wall
    self.bumped = false

    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt

        -- if collides the left wall
        if self.entity.x <= MAP_RENDER_OFFSET_X + 8 then
            self.entity.x = MAP_RENDER_OFFSET_X + 8
            self.bumped = true
        end
    elseif self.entity.direction == 'right' then
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        -- if collides the right wall
        if self.entity.x + self.entity.width >= VIRTUAL_WIDTH - MAP_RENDER_OFFSET_X - 8 then
            self.entity.x = VIRTUAL_WIDTH - MAP_RENDER_OFFSET_X - self.entity.width - 8
            self.bumped = true
        end
    elseif self.entity.direction == 'up' then
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt

        -- if collides the top wall
        if self.entity.y + self.entity.height <= MAP_RENDER_OFFSET_Y + TILE_SIZE * 4 + (TILE_SIZE / 4) then
            self.entity.y = (MAP_RENDER_OFFSET_Y + TILE_SIZE * 4) - (self.entity.height - TILE_SIZE / 4)
            self.bumped = true
        end
    elseif self.entity.direction == 'down' then
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt

        -- if collides the bottom wall
        if self.entity.y + self.entity.height >= VIRTUAL_HEIGHT - MAP_RENDER_OFFSET_Y then
            self.entity.y = VIRTUAL_HEIGHT - MAP_RENDER_OFFSET_Y - self.entity.height
            self.bumped = true
        end
    end
end

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

    -- DEBUG
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    love.graphics.setColor(255, 255, 255, 255)
end