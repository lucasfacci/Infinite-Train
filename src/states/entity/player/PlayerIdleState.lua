PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter()
    self.entity.offsetX = 0
    self.entity.offsetY = 5
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('a') or love.keyboard.isDown('d') or
        love.keyboard.isDown('w') or love.keyboard.isDown('s') then
        self.entity:changeState('walk')
    end
end