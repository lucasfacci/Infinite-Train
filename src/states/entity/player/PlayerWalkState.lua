PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player)
    self.entity = player

    self.entity.offsetX = 0
    self.entity.offsetY = 5
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('a') then
        self.entity:changeAnimation('walk-down')
    elseif love.keyboard.isDown('d') then
        self.entity:changeAnimation('walk-down')
    elseif love.keyboard.isDown('w') then
        self.entity:changeAnimation('walk-down')
    elseif love.keyboard.isDown('s') then
        self.entity:changeAnimation('walk-' .. self.entity.direction)
    else
        self.entity:changeState('idle')
    end

    EntityWalkState.update(self, dt)

    if self.bumped then
        if self.entity.direction == 'left' then
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'right' then
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'up' then
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
        else
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
        end
    end
end