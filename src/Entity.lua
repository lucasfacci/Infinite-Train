Entity = Class{}

function Entity:init(def)
    self.type = def.type
    self.direction = def.direction

    self.animations = self:createAnimations(def.animations)

    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0

    self.walkSpeed = def.walkSpeed

    self.health = def.health
    
    self.luck = math.random(8)

    self.dead = false
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture,
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

function Entity:changeState(name, params)
    self.stateMachine:change(name, params)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:update(dt)
    self.stateMachine:update(dt)

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function Entity:collides(target)
    -- specific collision rules for the chair object
    if target.type == 'chair' then
        -- it detects that the entity is at the left side of the target chair
        if self.x + self.width <= target.x then
            target.entityNameAndSide[self.type].side = 'left'
        end
        -- it detects that the entity is at the right side of the target chair
        if self.x >= target.x + target.width then
            target.entityNameAndSide[self.type].side = 'right'
        end
        -- it detects that the entity is at the top side of the target chair
        if self.y + self.height - self.height / 3 <= target.y then
            target.entityNameAndSide[self.type].side = 'top'
        end
        -- it detects that the entity is at the bottom side of the target chair
        if self.y >= target.y + target.height - self.height + self.height / 4 then
            target.entityNameAndSide[self.type].side = 'bottom'
        end
    end
    -- it returns true if the entity has collided with some game object and false if not
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Entity:fire(projectiles, r, g, b, target, level)
    gSounds['shoot']:play()
    table.insert(projectiles, Projectile(self, target, r, g, b, level))
end

function Entity:heal(healing)
    if self.health < 10 then
        self.health = self.health + healing
    end
end

function Entity:damage(dmg)
    self.health = self.health - dmg
end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:render()
    self.stateMachine:render()
end