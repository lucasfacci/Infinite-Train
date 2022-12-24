PlayState = Class{__includes = BaseState}

function PlayState:init(params)
    self.player = Player {
        direction =  params.direction or 'down',

        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,

        x = params.x or VIRTUAL_WIDTH / 2 - 16,
        y = params.y or VIRTUAL_HEIGHT / 2 - 16,

        width = 21,
        height = 32
    }

    self.train = Train(self.player)

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player) end,
        ['idle'] = function() return PlayerIdleState(self.player) end
    }

    self.player:changeState('idle')
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.train:update(dt)
end

function PlayState:render()
    self.train:render()
end