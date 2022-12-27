Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:collides(target)
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

function Player:render()
    Entity.render(self)
end