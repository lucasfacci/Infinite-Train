Train = Class{}

function Train:init(player, enemy)
    self.player = player
    self.enemy = enemy
    
    self.currentWagon = Wagon(self.player, self.enemy)
end

function Train:update(dt)
    self.currentWagon:update(dt)
end

function Train:render()
    self.currentWagon:render()
end