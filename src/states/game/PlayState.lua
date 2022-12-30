PlayState = Class{__includes = BaseState}

function PlayState:init(params)
    self.player = Player {
        direction = params.direction or 'down',

        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        health = ENTITY_DEFS['player'].health,

        x = params.x or VIRTUAL_WIDTH / 2 - ENTITY_DEFS['player'].height / 2,
        y = params.y or VIRTUAL_HEIGHT / 2 + MAP_RENDER_OFFSET_Y - ENTITY_DEFS['player'].height / 2,

        width = ENTITY_DEFS['player'].width,
        height = ENTITY_DEFS['player'].height
    }

    self.enemy = Entity {
        direction = 'down',

        animations = ENTITY_DEFS['cowboy'].animations,
        walkSpeed = ENTITY_DEFS['cowboy'].walkSpeed,
        health = ENTITY_DEFS['cowboy'].health,
        
        x = TILE_SIZE + MAP_RENDER_OFFSET_X,
        y = VIRTUAL_HEIGHT / 2 + MAP_RENDER_OFFSET_Y - ENTITY_DEFS['cowboy'].height / 2,

        width = ENTITY_DEFS['cowboy'].width,
        height = ENTITY_DEFS['cowboy'].height
    }

    self.train = Train(self.player, self.enemy)

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player) end,
        ['idle'] = function() return PlayerIdleState(self.player) end
    }

    self.enemy.stateMachine = StateMachine {
        ['walk'] = function() return EntityWalkState(self.enemy) end,
        ['idle'] = function() return EntityIdleState(self.enemy) end
    }

    self.player:changeState('idle')
    self.enemy:changeState('idle')
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

    if self.player.dead == false and self.player.health >= 1 then
        love.graphics.draw(gTextures['character_life'], gFrames['character_life'][self.player.health],
            VIRTUAL_WIDTH - 102, -1)
    else
        love.graphics.draw(gTextures['character_life'], gFrames['character_life'][1],
            VIRTUAL_WIDTH - 102, -1)
    end

    if self.enemy.dead == false and self.enemy.health >= 1 then
        love.graphics.draw(gTextures['cowboy_life'], gFrames['cowboy_life'][self.enemy.health],
            2, -1)
    else
        love.graphics.draw(gTextures['cowboy_life'], gFrames['cowboy_life'][1],
            2, -1)
    end
end