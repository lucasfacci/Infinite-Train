BossWalkState = Class{__includes = EntityWalkState}

function BossWalkState:init(boss, train)
    self.train = train
    self.entity = boss
    self.entity:changeAnimation('walk-' .. self.entity.direction)

    self.entity.offsetX = 0
    self.entity.offsetY = 0

    -- used for AI control
    self.moveDuration = 0
    self.movementTimer = 0

    self.bumped = false
end

function BossWalkState:update(dt)
    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)
end

function BossWalkState:processAI(params, dt)
    local wagon = params.wagon
    local directions = {'up', 'down'}

    if self.moveDuration == 0 or self.bumped then
        
        -- set an initial move duration and direction
        self.moveDuration = 1
        self.entity.direction = directions[math.random(#directions)]
        self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
    elseif self.movementTimer > self.moveDuration then
        self.movementTimer = 0

        -- chance to shoot
        if math.random(10) <= self.train.level then
            self.entity:changeState('shoot')
        else
            self.moveDuration = 1
            self.entity.direction = directions[math.random(#directions)]
            self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
        end
    end

    self.movementTimer = self.movementTimer + dt
end

function BossWalkState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

    -- -- DEBUG
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end