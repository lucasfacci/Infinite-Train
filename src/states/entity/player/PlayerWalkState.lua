PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player)
    self.entity = player

    self.entity.offsetX = 0
    self.entity.offsetY = 5
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('a') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-left')
    elseif love.keyboard.isDown('d') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-right')
    elseif love.keyboard.isDown('w') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('walk-up')
    elseif love.keyboard.isDown('s') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('walk-down')
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

    -- if collides the left door
    if self.entity.x <= 6 and self.entity.direction == 'left' then
        gStateStack:push(FadeInState({
            r = 0, g = 0, b = 0,
        }, 1,
        function()
            gStateStack:push(PlayState({
                direction = 'left',
                x = VIRTUAL_WIDTH - self.entity.width - 6,
                y = self.entity.y
            }))
            gStateStack:push(FadeOutState({
                r = 0, g = 0, b = 0,
            }, 1,
            function()
            end))
        end))
    end

    -- if collides the right door
    if self.entity.x >= VIRTUAL_WIDTH - self.entity.width - 6 and self.entity.direction == 'right' then
        gStateStack:push(FadeInState({
            r = 0, g = 0, b = 0,
        }, 1,
        function()
            gStateStack:push(PlayState({
                direction = 'right',
                x = 6,
                y = self.entity.y
            }))
            gStateStack:push(FadeOutState({
                r = 0, g = 0, b = 0,
            }, 1,
            function()
            end))
        end))
    end
end