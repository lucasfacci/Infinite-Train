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
require 'src/Hitbox'
require 'src/Projectile'
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
require 'src/states/entity/player/PlayerShootState'

require 'src/states/entity/boss/BossIdleState'
require 'src/states/entity/boss/BossWalkState'
require 'src/states/entity/boss/BossShootState'

require 'src/states/game/StartState'
require 'src/states/game/PlayState'
require 'src/states/game/FadeInState'
require 'src/states/game/FadeOutState'

gTextures = {
    ['start_background'] = love.graphics.newImage('graphics/start_background.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['tiles'] = love.graphics.newImage('graphics/tilesheet.png'),
    ['character_walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['cowboy_walk'] = love.graphics.newImage('graphics/cowboy_walk.png'),
    ['character_shoot'] = love.graphics.newImage('graphics/character_shoot.png'),
    ['cowboy_shoot'] = love.graphics.newImage('graphics/cowboy_shoot.png'),
    ['character_life'] = love.graphics.newImage('graphics/character_life.png'),
    ['cowboy_life'] = love.graphics.newImage('graphics/cowboy_life.png'),
    ['chairs'] = love.graphics.newImage('graphics/chairs.png')
}

gFrames = {
    ['background'] = GenerateQuads(gTextures['background'], 864, 64),
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['character_walk'] = GenerateQuads(gTextures['character_walk'], 19, 32),
    ['cowboy_walk'] = GenerateQuads(gTextures['cowboy_walk'], 18, 32),
    ['character_shoot'] = GenerateQuads(gTextures['character_shoot'], 32, 32),
    ['cowboy_shoot'] = GenerateQuads(gTextures['cowboy_shoot'], 32, 32),
    ['character_life'] = GenerateQuads(gTextures['character_life'], 100, 15),
    ['cowboy_life'] = GenerateQuads(gTextures['cowboy_life'], 100, 15),
    ['chairs'] = GenerateQuads(gTextures['chairs'], 32, 48)
}

gFonts = {
    ['rye-small'] = love.graphics.newFont('fonts/Rye-Regular.ttf', 16),
    ['rye-medium'] = love.graphics.newFont('fonts/Rye-Regular.ttf', 32),
    ['londrina-small'] = love.graphics.newFont('fonts/LondrinaSolid-Regular.ttf', 16),
    ['londrina-medium'] = love.graphics.newFont('fonts/LondrinaSolid-Regular.ttf', 32),
}