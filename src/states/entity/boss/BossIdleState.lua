BossIdleState = Class{__includes = EntityIdleState}

function BossIdleState:init(boss)
    self.boss = boss
    self.boss:changeAnimation('idle-' .. self.boss.direction)

    self.boss.offsetX = 0
    self.boss.offsetY = 0

    -- used for AI waiting
    self.waitDuration = 0
    self.waitTimer = 0
end

function BossIdleState:processAI(params, dt)
    if self.waitDuration == 0 then
        self.waitDuration = 1
    else
        self.waitTimer = self.waitTimer + dt
        
        if self.waitTimer > self.waitDuration then
            self.boss:changeState('walk')
        end
    end
end

function BossIdleState:render()
    local anim = self.boss.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.boss.x - self.boss.offsetX), math.floor(self.boss.y - self.boss.offsetY))
end