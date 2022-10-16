EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity)
    self.entity = entity
    self.entity:changeAnimation('walk-' .. self.entity.direction)

    self.bumped = false
end

function EntityWalkState:update(dt)
    self.bumped = false

    if love.keyboard.isDown('a') then
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        
        -- if self.entity.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
        --     self.entity.x = MAP_RENDER_OFFSET_X + TILE_SIZE
        --     self.bumped = true
        -- end
    elseif love.keyboard.isDown('d') then
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        -- if self.entity.x + self.entity.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
        --     self.entity.x = VIRTUAL_WIDTH - TILE_SIZE * 2 - self.entity.width
        --     self.bumped = true
        -- end
    elseif love.keyboard.isDown('w') then
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt

        -- if self.entity.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2 then 
        --     self.entity.y = MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2
        --     self.bumped = true
        -- end
    elseif love.keyboard.isDown('s') then
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt

        -- local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
        --     + MAP_RENDER_OFFSET_Y - TILE_SIZE

        -- if self.entity.y + self.entity.height >= bottomEdge then
        --     self.entity.y = bottomEdge - self.entity.height
        --     self.bumped = true
        -- end
    end
end

function EntityWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
end