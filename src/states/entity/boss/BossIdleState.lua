BossIdleState = Class{__includes = EntityIdleState}

function BossIdleState:init(boss)
    self.entity = boss
    self.entity:changeAnimation('idle-' .. self.entity.direction)

    -- used for AI waiting
    self.waitDuration = 0
    self.waitTimer = 0
end

function BossIdleState:processAI(params, dt)
    if self.waitDuration == 0 then
        self.waitDuration = math.random(5)
    else
        self.waitTimer = self.waitTimer + dt
        
        if self.waitTimer > self.waitDuration then
            self.entity:changeState('walk')
        end
    end
end

function BossIdleState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))
end