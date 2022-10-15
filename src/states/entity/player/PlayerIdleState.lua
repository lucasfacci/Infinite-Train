PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
    self.entity.offsetX = 0
    self.entity.offsetY = 5
end

function PlayerIdleState:update(dt)

end