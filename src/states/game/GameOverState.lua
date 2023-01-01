GameOverState = Class{__includes = BaseState}

function GameOverState:init(level)
    self.level = level
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:push(FadeInState({
            r = 0, g = 0, b = 0
        }, {}, 1,
        function()
            gStateStack:push(PlayState({}))
            gStateStack:push(FadeOutState({
                r = 0, g = 0, b = 0
            }, {}, 1,
            function() end))
        end))
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
    love.graphics.setFont(gFonts['rye-medium'])
    love.graphics.setColor(255/255, 219/255, 49/255)
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['rye-small'])
    love.graphics.printf('Level Reached: ' .. self.level, 0, VIRTUAL_HEIGHT / 2  - 12, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter To Play Again', 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press ESC To Exit', 0, VIRTUAL_HEIGHT / 2 + 52, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end