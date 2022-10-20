Train = Class{}

function Train:init(player)
    self.player = player
    
    self.currentWagon = Wagon(self.player)
end

function Train:update(dt)
    self.currentWagon:update(dt)
end

function Train:render()
    self.currentWagon:render()
end