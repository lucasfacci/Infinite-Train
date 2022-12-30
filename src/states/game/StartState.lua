StartState = Class{__includes = BaseState}

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateStack:push(FadeInState({
            r = 0, g = 0, b = 0
        }, 1,
        function()
            gStateStack:push(PlayState({}))
            gStateStack:push(FadeOutState({
                r = 0, g = 0, b = 0
            }, 1,
            function() end))
        end))
    end
end

function StartState:render()
    love.graphics.draw(gTextures['start_background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['start_background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['start_background']:getHeight())

    love.graphics.setFont(gFonts['rye-medium'])
    love.graphics.setColor(255/255, 219/255, 49/255)
    -- love.graphics.setColor(207/255, 181/255, 59/255)
    love.graphics.printf('Infinite', 3, VIRTUAL_HEIGHT / 2 - 35, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Train', 3, VIRTUAL_HEIGHT / 2 - 3, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['rye-small'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 84, VIRTUAL_WIDTH, 'center')
end