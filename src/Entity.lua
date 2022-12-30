Entity = Class{}

function Entity:init(def)
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
        if self.x + self.width <= target.x then
            target.lastCollisionSide = 'left'
        end

        if self.x >= target.x + target.width then
            target.lastCollisionSide = 'right'
        end

        if self.y + self.height - self.height / 3 <= target.y then
            target.lastCollisionSide = 'top'
        end

        if self.y >= target.y + target.height - self.height + self.height / 4 then
            target.lastCollisionSide = 'bottom'
        end
    end
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:render()
    self.stateMachine:render()
end