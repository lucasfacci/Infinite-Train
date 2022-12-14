Projectile = Class{}

function Projectile:init(entity, target, r, g, b, velocity)
    self.entity = entity
    self.target = target

    self.r = r
    self.g = g
    self.b = b

    self.velocity = velocity

    self.direction = self.entity.direction

    -- if the player is too close, he will die instantly with a bullet
    if self.entity.type == 'cowboy' and
        (self.entity.direction == 'left' or
            self.target.x < self.entity.x + self.entity.width + TILE_SIZE * 2) then
        self.damage = 10
    -- otherwise it will take a normal damage
    else
        self.damage = 1
    end

    if self.direction == 'left' then
        self.x = self.entity.x
        self.y = self.entity.y + 16

        self.width = 3
        self.height = 1
    elseif self.direction == 'right' then
        self.x = self.entity.x + 19
        self.y = self.entity.y + 16

        self.width = 3
        self.height = 1
    elseif self.direction == 'down' then
        self.x = self.entity.x + 5
        self.y = self.entity.y + 16

        self.width = 1
        self.height = 3
    else
        self.x = self.entity.x + 12
        self.y = self.entity.y

        self.width = 1
        self.height = 3
    end
    
    self.hitbox = Hitbox(self.x, self.y, self.width, self.height)
    self.hit = false
end

function Projectile:update(dt)
    if self.velocity then
        if self.direction == 'left' then
            self.dx = -100 - self.velocity * 5
            self.dy = 0
        elseif self.direction == 'right' then
            self.dx = 100 + self.velocity * 5
            self.dy = 0
        elseif self.direction == 'up' then
            self.dx = 0
            self.dy = -100 - self.velocity * 5
        else
            self.dx = 0
            self.dy = 100 + self.velocity * 5
        end
    else
        if self.direction == 'left' then
            self.dx = -100
            self.dy = 0
        elseif self.direction == 'right' then
            self.dx = 100
            self.dy = 0
        elseif self.direction == 'up' then
            self.dx = 0
            self.dy = -100
        else
            self.dx = 0
            self.dy = 100
        end
    end

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
    self.dx = 0
    self.dy = 0

    self.hitbox.x = self.x
    self.hitbox.y = self.y

    if self.target:collides(self.hitbox) and not self.target.dead then
        gSounds['damage']:play()
        self.hit = true
        self.target:damage(self.damage)
    end
end

function Projectile:render()
    love.graphics.setColor(self.r/255, self.g/255, self.b/255, 255)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 255)
end