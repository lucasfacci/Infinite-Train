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

    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    self.dx = 0
    self.dy = 0

    self.onCollide = function() end
end

function GameObject:update(dt, entities, objects)

end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)

end