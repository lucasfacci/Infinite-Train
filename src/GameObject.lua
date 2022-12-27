GameObject = Class{}

function GameObject:init(def, x, y)
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    self.solid = def.solid

    self.opacity = 1

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    self.dx = 0
    self.dy = 0

    -- it keeps track of the side that the collision happened last time/is happening
    self.lastCollisionSide = nil

    self.onCollide = function() end
end

function GameObject:update(dt, entities, objects)

end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.setColor(1, 1, 1, self.opacity)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
    love.graphics.setColor(1, 1, 1, 1)
end