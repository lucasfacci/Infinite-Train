BossShootState = Class{__includes = BaseState}

function BossShootState:init(boss)
    self.entity = boss

    self.entity.direction = 'right'

    self.entity:changeAnimation('shoot-right')

    -- render offset for spaced character sprite
    self.entity.offsetX = 6
    self.entity.offsetY = 0

    -- used for AI waiting
    self.waitDuration = 0
    self.waitTimer = 0

    Event.dispatch('boss-fire')
end

function BossShootState:processAI(params, dt)
    if self.waitDuration == 0 then
        self.waitDuration = 1
    else
        self.waitTimer = self.waitTimer + dt
        
        if self.waitTimer > self.waitDuration then
            self.entity:changeState('walk')
        end
    end
end

function BossShootState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
end