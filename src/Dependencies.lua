Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'
Lighter = require 'lib/lighter'

require 'src/Animation'
require 'src/constants'
require 'src/Entity'
require 'src/entity_defs'
require 'src/GameObject'
require 'src/game_object_defs'
require 'src/Player'
require 'src/StateMachine'
require 'src/Util'

require 'src/world/Train'
require 'src/world/Wagon'

require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'

require 'src/states/game/StartState'
require 'src/states/game/PlayState'
require 'src/states/game/FadeInState'
require 'src/states/game/FadeOutState'

gTextures = {
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['tiles'] = love.graphics.newImage('graphics/tilesheet.png'),
    ['character_walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['chairs'] = love.graphics.newImage('graphics/chairs.png')
}

gFrames = {
    ['background'] = GenerateQuads(gTextures['background'], 864, 64),
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['character_walk'] = GenerateQuads(gTextures['character_walk'], 21, 32),
    ['chairs'] = GenerateQuads(gTextures['chairs'], 32, 48)
}