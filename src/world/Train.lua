Train = Class{}

function Train:init(player, boss)
    self.player = player
    self.boss = boss
    
    self.currentWagon = Wagon(self.player, self.boss)
end

function Train:update(dt)
    self.currentWagon:update(dt)
end

function Train:render()
    self.currentWagon:render()
end