Train = Class{}

function Train:init(player, boss, level)
    self.player = player
    self.boss = boss

    self.level = level
    
    self.currentWagon = Wagon(self.player, self.boss, self.level)
end

function Train:update(dt)
    self.currentWagon:update(dt)
end

function Train:render()
    self.currentWagon:render()
end