BossShootState = Class{__includes = BaseState}

function BossShootState:init(boss, player)
    self.boss = boss
    self.player = player

    if self.player.x < self.boss.x then
        self.boss.direction = 'left'
    else
        self.boss.direction = 'right'
    end
    
    self.boss:changeAnimation('shoot-' .. self.boss.direction)

    -- render offset for spaced character sprite
    self.boss.offsetX = 6
    self.boss.offsetY = 0

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
            self.boss:changeState('walk')
        end
    end
end

function BossShootState:render()
    local anim = self.boss.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.boss.x - self.boss.offsetX), math.floor(self.boss.y - self.boss.offsetY))
end