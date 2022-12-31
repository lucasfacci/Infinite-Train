PlayState = Class{__includes = BaseState}

function PlayState:init(params)
    self.level = params.level

    self.player = Entity {
        type = ENTITY_DEFS['player'].type,
        
        direction = params.direction or 'down',

        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        health = params.health or ENTITY_DEFS['player'].health,

        x = params.x or VIRTUAL_WIDTH / 2 - ENTITY_DEFS['player'].height / 2,
        y = params.y or VIRTUAL_HEIGHT / 2 + MAP_RENDER_OFFSET_Y - ENTITY_DEFS['player'].height / 2,

        width = ENTITY_DEFS['player'].width,
        height = ENTITY_DEFS['player'].height
    }

    self.boss = Entity {
        type = ENTITY_DEFS['cowboy'].type,

        direction = 'down',

        animations = ENTITY_DEFS['cowboy'].animations,
        walkSpeed = ENTITY_DEFS['cowboy'].walkSpeed,
        health = ENTITY_DEFS['cowboy'].health,
        
        x = TILE_SIZE + MAP_RENDER_OFFSET_X,
        y = VIRTUAL_HEIGHT / 2 + MAP_RENDER_OFFSET_Y - ENTITY_DEFS['cowboy'].height / 2,

        width = ENTITY_DEFS['cowboy'].width,
        height = ENTITY_DEFS['cowboy'].height
    }

    self.train = Train(self.player, self.boss, self.level)

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self.train) end,
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['shoot'] = function() return PlayerShootState(self.player) end
    }

    self.boss.stateMachine = StateMachine {
        ['walk'] = function() return BossWalkState(self.boss) end,
        ['idle'] = function() return BossIdleState(self.boss) end,
        ['shoot'] = function() return BossShootState(self.boss) end
    }

    self.player:changeState('idle')
    self.boss:changeState('idle')
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    
    self.train:update(dt)
end

function PlayState:render()
    love.graphics.push()
    self.train:render()
    love.graphics.pop()

    if not self.player.dead then
        love.graphics.draw(gTextures['character_life'], gFrames['character_life'][self.player.health],
            VIRTUAL_WIDTH - 102, -1)
    end

    if not self.boss.dead then
        love.graphics.draw(gTextures['cowboy_life'], gFrames['cowboy_life'][self.boss.health],
            2, -1)
    end

    love.graphics.setFont(gFonts['londrina-small'])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf('Level: ' .. self.level, 0, -5, VIRTUAL_WIDTH, 'center')
end