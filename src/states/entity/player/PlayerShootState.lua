PlayerShootState = Class{__includes = BaseState}

function PlayerShootState:init(player)
    self.entity = player

    self.entity:changeAnimation('shoot-' .. self.entity.direction)

    -- render offset for spaced character sprite
    self.entity.offsetX = 6
    self.entity.offsetY = 0

    -- used for AI waiting
    self.waitDuration = 0
    self.waitTimer = 0

    Event.dispatch('player-fire')
end

function PlayerShootState:update(dt)
    if self.waitDuration == 0 then
        self.waitDuration = 1
    else
        self.waitTimer = self.waitTimer + dt
        
        if self.waitTimer > self.waitDuration then
            self.entity:changeState('idle')
        end
    end
end

function PlayerShootState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
end