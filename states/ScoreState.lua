--[[
    ScoreState Class

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 30, VIRTUAL_WIDTH, 'center')
-------------------------------------------------REWARD SYSTEM----------------------------------------------------
    if self.score < 25 then
        love.graphics.printf('You got BRONZE!', 0, 150, VIRTUAL_WIDTH, 'center')
    elseif self.score > 25 then
            love.graphics.printf('You got SILVER!', 0, 150, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('You got GOLD!', 0, 150, VIRTUAL_WIDTH, 'center')
    end
------------------------------------------------------------------------------------------------------------------
        love.graphics.printf('Press Enter to Play Again!', 0, 240, VIRTUAL_WIDTH, 'center')
end